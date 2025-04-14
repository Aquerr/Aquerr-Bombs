#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

INFO_1("Logic: %1",_logic);
INFO_1("Units: %1",_units);
INFO_1("Activated: %1",_activated);

private _synchronizedObjects = synchronizedObjects _logic;

private _bombTime = _logic getVariable ["BombTime", "60"];
private _shouldBeep = _logic getVariable ["ShouldBeep", true];
private _wireSign = _logic getVariable ["WireSign", "|"];
private _wireCount = _logic getVariable ["WireCount", "60"];
private _explosionClassName = _logic getVariable ["ExplosionClassName", "DemoCharge_Remote_Ammo"];
private _explosionClassNameOverride = _logic getVariable ["ExplosionClassNameOverride", ""];
private _afterDefuseCode = compile (_logic getVariable ["AfterDefuseCode", '{}']);

INFO_1("_bombTime: %1",_bombTime);
INFO_1("_shouldBeep: %1",_shouldBeep);
INFO_1("_wireSign: %1",_wireSign);
INFO_1("_wireCount: %1",_wireCount);
INFO_1("_explosionClassName: %1",_explosionClassName);
INFO_1("_explosionClassNameOverride: %1",_explosionClassNameOverride);
INFO_1("_afterDefuseCode: %1",_afterDefuseCode);

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

if ((count _synchronizedObjects) > 0) then {
	{
		[_x, _bombTime, _shouldBeep, _wireSign, _wireCount, _explosionClassName, _afterDefuseCode] call EFUNC(main,scroll_action_bomb_hint_text_image);
	} forEach _synchronizedObjects;
};
