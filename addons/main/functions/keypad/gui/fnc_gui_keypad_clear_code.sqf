#include "..\..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Clears entered code in keypad.

	Example:
        [] call abombs_main_fnc_gui_keypad_clear_code;
*/

params [];

_defuser = player;
_bomb = GVAR(Bomb_Interface_Target);
[_defuser, _bomb] call FUNC(keypad_clear_entered_code);