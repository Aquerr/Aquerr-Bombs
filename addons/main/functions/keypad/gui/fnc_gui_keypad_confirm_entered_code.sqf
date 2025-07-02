#include "..\..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Confirms entered code in keypad. Used from GUI. Should not be used by other mods.

	Example:
        [] call abombs_main_fnc_gui_keypad_confirm_entered_code;
*/

params [];

_defuser = player;
_bomb = GVAR(Bomb_Interface_Target);
[_bomb, _defuser, true] call FUNC(keypad_confirm_entered_code);
