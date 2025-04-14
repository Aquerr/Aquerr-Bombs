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

private _objectClassNames = parseSimpleArray (_logic getVariable ["ClassNames", "[]"]);
private _shouldDeleteWreckAfterExplosion = _logic getVariable ["DeleteAfterExplosion", true];
private _explosionClassName = _logic getVariable ["ExplosionClassName", "DemoCharge_Remote_Ammo"];
private _explosionClassNameOverride = _logic getVariable ["ExplosionClassNameOverride", ""];
private _requiredHits = _logic getVariable ["RequiredHits", 5];
private _fixedRequiredHits = _logic getVariable ["FixedRequiredHits", false];

INFO_1("ClassNames: %1",_objectClassNames);
INFO_1("ShouldDeleteWreck: %1",_shouldDeleteWreckAfterExplosion);
INFO_1("ExplosionClassName: %1",_explosionClassName);
INFO_1("ExplosionClassNameOverride: %1",_explosionClassNameOverride);
INFO_1("RequiredHits: %1",_requiredHits);
INFO_1("FixedRequiredHits: %1",_fixedRequiredHits);

if (not(_explosionClassNameOverride isEqualTo "")) then {
	_explosionClassName = _explosionClassNameOverride;
};

if ((count _objectClassNames) > 0) then {
	[_objectClassNames, _shouldDeleteWreckAfterExplosion, _explosionClassName, _requiredHits, _fixedRequiredHits] call EFUNC(main,register_explosive_handlers_global);
};

if ((count _synchronizedObjects) > 0) then {
	{
		[_x, _shouldDeleteWreckAfterExplosion, _explosionClassName, _requiredHits, _fixedRequiredHits] call EFUNC(main,register_explosive_handlers_for_object);
	} forEach _synchronizedObjects;
};