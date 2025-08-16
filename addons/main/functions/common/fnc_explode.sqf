#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
                Performs the explosion.

	Parameter(s):
                0: OBJECT/ARRAY - the object to explode OR position ATL where te explosion should be created
                1: STRING - the explosion class name 
                2: BOOL - should delete object after explosion?

	Example:
                [_object, "DemoCharge_Remote_Ammo", true] call abombs_main_fnc_explode;
                [_explosionPosition, false] call abombs_main_fnc_explode;
*/

params [
        ["_object", objNull, [objNull, []]], 
        ["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]],
        ["_shouldDeleteObjectAfterExplosion", true, [true]]
];

private _explosionPosition = [];

if (_object isEqualType []) then {
        // If position
        _explosionPosition = _object;
        _shouldDeleteObjectAfterExplosion = false;
} else {
        // If object
        _explosionPosition = getPosATL _object;
};

_explosive = createVehicle [_explosionClassName, _explosionPosition, [], 0, "CAN_COLLIDE"];
if(_shouldDeleteObjectAfterExplosion) then {
        deleteVehicle _object;
        [_object] remoteExec [QFUNC(removeRegisteredBomb)]; // Just in case if it was a bomb
};

_explosive setDamage 1;
