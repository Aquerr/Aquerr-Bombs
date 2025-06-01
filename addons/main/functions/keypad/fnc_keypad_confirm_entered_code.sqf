#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used to confirm entered keypad code. Local only.

	Parameter(s):
        1: OBJECT - the object that has a keypad attached to
        0: OBJECT - the user who interacted with keypad

	Example:
        [_object, _user] call abombs_main_fnc_keypad_confirm_entered_code;
*/

params ["_object", "_user"];

_enteredCode = _object getVariable ["aquerr_bomb_entered_code", ""];
_solutionCode = _object getVariable ["abombs_keypad_solution_code", ""];
if ((count _enteredCode) >= (count _solutionCode)) then {
    if (_solutionCode isEqualTo _enteredCode) then {
        _successFunction = _object getVariable ["abombs_keypad_success_function", {}];
        [_object, _user] call _successFunction;

        _afterDefuseFunction = _object getVariable ["aquerr_bomb_after_defuse_function", {}];
        [_object, _user] call _afterDefuseFunction; 
    } else {
        _failureFunction = _object getVariable ["abombs_keypad_failure_function", {}];
        [_object, _user] call _failureFunction;
    };
};