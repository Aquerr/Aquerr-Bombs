#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Enters a digit in keypad bomb from GUI. Local only.

	Parameter(s):
        0: NUMBER - the digit

	Example:
        [2] call abombs_main_fnc_gui_bomb_enter_digit;
*/

params["_digit"];

_defuser = player;
_bomb = GVAR(Bomb_Interface_Target);
[_defuser, _bomb, _digit, false] call FUNC(bomb_enter_digit);