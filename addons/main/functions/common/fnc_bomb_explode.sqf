#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Makes the bomb explode. Local only.

	Parameter(s):
    	0: OBJECT - the bomb
        1: PLAYER - the defuser player, can be objNull.

	Example:
        [_bomb, _player] call abombs_main_fnc_bomb_explode;
*/

params ["_bomb", "_defuser"];

[QGVAR(bomb_explode), [_bomb, _defuser]] call CBA_fnc_globalEvent;

[
	_bomb, 
	GETVAR(_bomb,aquerr_explosion_class_name,"DemoCharge_Remote_Ammo"),
	GETVAR(_object,aquerr_delete_after_explosion,true)
] call FUNC(explode);
