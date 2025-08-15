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
private _roundsCount = _logic getVariable ["RoundsCount", "60"];
private _serialNumber = _logic getVariable ["SerialNumber", "Unknown"];
private _explosionClassName = _logic getVariable ["ExplosionClassName", "DemoCharge_Remote_Ammo"];
private _explosionClassNameOverride = _logic getVariable ["ExplosionClassNameOverride", ""];
private _afterDefuseCode = compile (_logic getVariable ["AfterDefuseCode", '{}']);
private _maxDefuseAttempts = _logic getVariable ["MaxDefuseAttempts", "1"];
private _removeShotVulnerabilityAfterDefuse = _logic getVariable ["RemoveShotVulnerabilityAfterDefuse", false];
private _requireEOD = _logic getVariable ["RequireEOD", false];
private _requiredDefusalItemsArray = parseSimpleArray (_logic getVariable ["RequiredDefusalItems", "[]"]);

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _initBombFunction = {
	_this call EFUNC(main,init_memory_bomb_full);
	_bomb = _this select 0;
	[_bomb, _this select 9] call EFUNC(main,set_require_eod);
	[_bomb, _this select 10] call EFUNC(main,set_require_defusal_items);
};

{
	private _bombParams = [
		_x, 
		_bombTime, 
		_shouldBeep, 
		_roundsCount, 
		_maxDefuseAttempts, 
		_explosionClassName, 
		_removeShotVulnerabilityAfterDefuse, 
		_serialNumber, 
		_afterDefuseCode,
		_requireEOD,
		_requiredDefusalItemsArray
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
