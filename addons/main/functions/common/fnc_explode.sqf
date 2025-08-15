#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Performs the explosion.

	Parameter(s):
        0: OBJECT - the object to explode

	Example:
        [_object] call abombs_main_fnc_explode;
*/

params ["_object"];

_explosionClassName = GETVAR(_object,aquerr_explosion_class_name,DemoCharge_Remote_Ammo);
_explosive = createVehicle [_explosionClassName, (getPosATL _object), [], 0, "CAN_COLLIDE"];

_shouldDeleteWreckAfterExplosion = GETVAR(_object,aquerr_delete_after_explosion,true);
if(_shouldDeleteWreckAfterExplosion) then {
    deleteVehicle _object;
    [_object] remoteExec [QFUNC(removeRegisteredBomb)]; // Just in case if it was a bomb
};

_explosive setDamage 1;
