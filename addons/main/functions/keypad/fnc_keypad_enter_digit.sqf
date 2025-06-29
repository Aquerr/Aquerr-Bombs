#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Enters a digit in keypad bomb. Local only.

	Parameter(s):
        0: OBJECT - the user who entered the digit
        1: OBJECT - the object that has a keypad attached to
        2: NUMBER - the digit
        3: BOOL - if current code should be displayed in hint

	Example:
        [_player, _object, 2] call abombs_main_fnc_keypad_enter_digit;
*/

params ["_user", "_object", "_digit", ["_showInHint", false]];

private _isArmed = _object getVariable ["abombs_bomb_is_armed", false];
if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

_newCode = (format  ["%1%2", (_object getVariable ["aquerr_bomb_entered_code", ""]), _digit]);
_object setVariable ["aquerr_bomb_entered_code", _newCode, true];
[QGVAR(BombEnteredDigit), [_object, _user]] call CBA_fnc_globalEvent;

if (_showInHint) then {
    hint (format [(LLSTRING(CurrentBombCode)) + ": %1", _newCode]);
};

[_object, _user] call FUNC(keypad_confirm_entered_code);