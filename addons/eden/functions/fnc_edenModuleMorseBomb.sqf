#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _bombTime = _logic getVariable ["BombTime", "60"];
private _shouldBeep = _logic getVariable ["ShouldBeep", true];
private _maxDefuseAttempts = _logic getVariable ["MaxDefuseAttempts", "1"];
private _encodedMessage = _logic getVariable ["EncodedMessage", ""];
private _solutionMessage = _logic getVariable ["SolutionMessage", ""];
private _explosionClassName = _logic getVariable ["ExplosionClassName", "DemoCharge_Remote_Ammo"];
private _explosionClassNameOverride = _logic getVariable ["ExplosionClassNameOverride", ""];
private _removeShotVulnerabilityAfterDefuse = _logic getVariable ["RemoveShotVulnerabilityAfterDefuse", false];
private _serialNumber = _logic getVariable ["SerialNumber", "Unknown"];
private _afterDefuseCode = compile (_logic getVariable ["AfterDefuseCode", '{}']);

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _initBombFunction = {
	_this call EFUNC(main,init_morse_bomb_full);
};

{
	private _bombParams = [
		_x, 
		_bombTime, 
		_shouldBeep, 
		_maxDefuseAttempts, 
		_encodedMessage, 
		_solutionMessage, 
		_explosionClassName, 
		_removeShotVulnerabilityAfterDefuse, 
		_serialNumber, 
		_afterDefuseCode
	];

	if (count (_syncedTriggers) > 0) then {
		{
			private _trigger = _x;
			// Trigger based init
			[
				_trigger,
				_bombParams,
				_initBombFunction
			] spawn {
				params [
					"_trigger",
					"_bombParams",
					"_initBombFunction"
				];

        		waitUntil { sleep 1; triggerActivated _trigger };

				_bombParams call _initBombFunction;
			};
		} forEach _syncedTriggers;
	} else {
		// Regular init (no trigger)
		_bombParams call _initBombFunction;
	};
} forEach _connectedObjects;
