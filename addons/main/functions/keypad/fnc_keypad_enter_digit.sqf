#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Enters a digit in keypad. Local only.

	Parameter(s):
        0: OBJECT - the user who entered the digit
        1: OBJECT - the object that has a keypad attached to
        2: NUMBER - the digit
        3: BOOL - if current code should be displayed in hint

	Example:
        [_player, _object, 2] call abombs_main_fnc_keypad_enter_digit;
*/

params ["_user", "_object", "_digit", ["_showInHint", false]];

private _canEnterDigitFunction = _object getVariable ["abombs_keypad_can_enter_digit_function", {}];
private _canEnterDigit = [_user, _object, _digit] call _canEnterDigitFunction;

if (!_canEnterDigit) exitWith {};

_newCode = (format  ["%1%2", (_object getVariable ["abombs_keypad_entered_code", ""]), _digit]);
_object setVariable ["abombs_keypad_entered_code", _newCode, true];
[QGVAR(KeypadEnteredDigit), [_object, _user]] call CBA_fnc_globalEvent;

if (_showInHint) then {
    hint (format [(LLSTRING(CurrentCode)) + ": %1", _newCode]);
};

[_object, _user] call FUNC(keypad_confirm_entered_code);
