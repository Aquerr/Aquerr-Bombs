#include "..\script_component.hpp"
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

params ["_bomb", "_defuser"];

[QGVAR(bomb_explode), [_bomb, _defuser]] call CBA_fnc_globalEvent;

_explosionClassName = _bomb getVariable ["aquerr_explosion_class_name", "DemoCharge_Remote_Ammo"];
_explosive = _explosionClassName createVehicle (getPos _bomb);
deleteVehicle _bomb;
[_bomb] call FUNC(removeRegisteredBomb);
_explosive setDamage 1;
