#include "script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Makes the bomb explode. Local only.

	Parameter(s):
        0: OBJECT - the defuser player, can be objNull.
        1: OBJECT - the bomb

	Example:
        [_player, _bomb] call abombs_main_fnc_bomb_explode;
*/

params ["_defuser", "_bomb"];

_explosionClassName = _bomb getVariable ["aquerr_explosion_class_name", "DemoCharge_Remote_Ammo"];
_explosive = _explosionClassName createVehicle (getPos _bomb);
deleteVehicle _bomb;
_explosive setDamage 1;