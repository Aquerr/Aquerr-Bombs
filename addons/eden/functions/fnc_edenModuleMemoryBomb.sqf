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

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

if ((count _synchronizedObjects) > 0) then {
	{
		[_x, _bombTime, _shouldBeep, _roundsCount, _maxDefuseAttempts, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber, _afterDefuseCode] call EFUNC(main,init_memory_bomb_full);
	} forEach _synchronizedObjects;
};
