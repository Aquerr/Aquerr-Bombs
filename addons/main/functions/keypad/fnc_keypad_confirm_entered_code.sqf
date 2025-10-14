#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used to confirm entered keypad code. Local only.

	Parameter(s):
        0: OBJECT - the object that has a keypad attached to
        1: OBJECT - the user who interacted with keypad
        2: BOOL - if forced. (Don't check if endered code length match the solution code)

	Example:
        [_object, _user] call abombs_main_fnc_keypad_confirm_entered_code;
*/

params ["_object", "_user", ["_forced", false, [false]]];

private _canConfirmFunction = _object getVariable ["abombs_keypad_can_confirm_function", {}];
private _canConfirm = [_object, _user] call _canConfirmFunction;
if (!_canConfirm) exitWith {};

private _enteredCode = _object getVariable ["abombs_keypad_entered_code", ""];
private _solutionCode = _object getVariable ["abombs_keypad_solution_code", ""];
if (((count _enteredCode) >= (count _solutionCode)) || _forced) then {
    if (_solutionCode isEqualTo _enteredCode) then {
        private _successFunction = _object getVariable ["abombs_keypad_success_function", {}];
        [_object, _user] call _successFunction;
    } else {
        private _failureFunction = _object getVariable ["abombs_keypad_failure_function", {}];
        [_object, _user] call _failureFunction;
    };
};
