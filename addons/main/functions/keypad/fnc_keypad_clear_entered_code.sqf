#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Clears entered code in keypad bomb. Local only.

	Example:
        [] call abombs_main_fnc_keypad_clear_entered_code;
*/

params ["_defuser", "_bomb"];

_bomb setVariable ["abombs_keypad_entered_code", "", true];
hint LLSTRING(CodeCleared);
[QGVAR(BombClearedEnteredCode), [_bomb, _defuser]] call CBA_fnc_globalEvent;
