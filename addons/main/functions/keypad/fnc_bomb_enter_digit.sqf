#include "..\script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Enters a digit in keypad bomb. Local only.

	Parameter(s):
        0: OBJECT - the defuser player
        1: OBJECT - the bomb
        2: NUMBER - the digit
        3: BOOL - if current code should be displayed in hint

	Example:
        [_player, _bomb, 2] call abombs_main_fnc_bomb_enter_digit;
*/


//TODO: Rename to fnc_keypad_enter_digit.sqf
//TODO: Add variables for storing success callback and failure callback. 

params ["_defuser", "_bomb", "_digit", ["_showInHint", false]];

_clientCleanUpFunction = _bomb getVariable ["aquerr_bomb_client_cleanup_function", {}];
_afterDefuseFunction = _bomb getVariable ["aquerr_bomb_after_defuse_function", {}];

private _isArmed = _bomb getVariable ["aquerr_bomb_is_armed", false];
if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

_newCode = (format  ["%1%2", (_bomb getVariable ["aquerr_bomb_entered_code", ""]), _digit]);
_bomb setVariable ["aquerr_bomb_entered_code", _newCode, true];
[QGVAR(BombEnteredDigit), [_bomb, _defuser]] call CBA_fnc_globalEvent;

if (_showInHint) then {
    hint (format [(LLSTRING(CurrentBombCode)) + ": %1", _newCode]);
};

_solutionCode = _bomb getVariable ["aquerr_bomb_solution_code", ""];
if ((count _newCode) >= (count _solutionCode)) then {
    if (_solutionCode isEqualTo _newCode) then {
        [_bomb] call _clientCleanUpFunction;
        _bomb setVariable ["aquerr_bomb_is_armed", false, true];
        hint LLSTRING(BombDefused);
        [_bomb, QGVAR(BombDefuse)] remoteExec ["say3D"];

        [QGVAR(BombDefused), [_bomb, _defuser]] call CBA_fnc_globalEvent;

        _afterDefuseFunction = _bomb getVariable ["aquerr_bomb_after_defuse_function", {}];
        [_bomb, _defuser] call _afterDefuseFunction; 
    } else {
        [_bomb] call _clientCleanUpFunction;

        if (dialog) then {
            closeDialog 0;
        };

        [_defuser, _bomb] call FUNC(bomb_explode);
    };
};