#include "..\..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Enters a digit in keypad from GUI. Local only.

	Parameter(s):
        0: NUMBER - the digit

	Example:
        [2] call abombs_main_fnc_gui_keypad_enter_digit;
*/

params["_digit"];

_defuser = player;
_bomb = GVAR(Interface_Target_Object);

_newCode = (format  ["%1%2", (_bomb getVariable ["abombs_keypad_entered_code", ""]), _digit]);
_bomb setVariable ["abombs_keypad_entered_code", _newCode, true];
