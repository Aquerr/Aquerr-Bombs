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

private _isArmed = _bomb getVariable ["abombs_bomb_is_armed", false];
if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

_enteredCode = _object getVariable ["aquerr_bomb_entered_code", ""];
_solutionCode = _object getVariable ["abombs_keypad_solution_code", ""];
if ((count _enteredCode) >= (count _solutionCode)) then {
    if (_solutionCode isEqualTo _enteredCode) then {
        [_object, _user] call FUNC(bomb_defuse);
    } else {
        _maxDefuseAttempts = _object getVariable ["abombs_bomb_max_defuse_attempts", 1];
        _attempts = (_object getVariable ["abombs_bomb_defuse_attempts", 0]) + 1;
        _object setVariable ["abombs_bomb_defuse_attempts", _attempts, true];
        if (_attempts >= _maxDefuseAttempts) then {
            _failureFunction = _object getVariable ["abombs_keypad_failure_function", {}];
            [_object, _user] call _failureFunction;
        } else {
            _object setVariable ["aquerr_bomb_entered_code", "", true];
            hint "Bomb still ticks...";
        };
    };
};