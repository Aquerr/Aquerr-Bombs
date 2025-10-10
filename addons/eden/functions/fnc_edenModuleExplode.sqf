#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _delay = _logic getVariable ["Delay", 0];
private _explosionClassName = _logic getVariable ["ExplosionClassName", "DemoCharge_Remote_Ammo"];
private _explosionClassNameOverride = _logic getVariable ["ExplosionClassNameOverride", ""];
private _shouldDeleteWreckAfterExplosion = _logic getVariable ["DeleteAfterExplosion", true];

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _explodeFunction = {
	params ["_objectOrLocation", "_delay", "_explosionClassName", "_shouldDeleteWreckAfterExplosion"];
	[
		{_this call EFUNC(main,explode);}, 
		[_objectOrLocation, _explosionClassName, _shouldDeleteWreckAfterExplosion], 
		_delay
	] 
	call CBA_fnc_waitAndExecute;
};

// If nothing is connected then use this module location
if ((count _connectedObjects) == 0) then {
	_connectedObjects pushBack (getPosATL _logic);
};

{
	private _explodeParams = [
		_x, 
		_delay,
		_explosionClassName, 
		_shouldDeleteWreckAfterExplosion
	];

	if (count (_syncedTriggers) > 0) then {
		{
			private _trigger = _x;
			// Trigger based init
			[
				_trigger,
				_explodeParams,
				_explodeFunction
			] spawn {
				params [
					"_trigger",
					"_explodeParams",
					"_explodeFunction"
				];

				waitUntil { sleep 1; triggerActivated _trigger };

				_explodeParams call _explodeFunction;
			};
		} forEach _syncedTriggers;
	} else {
		// Regular init (no trigger)
		_explodeParams call _explodeFunction;
	};
} forEach _connectedObjects;
