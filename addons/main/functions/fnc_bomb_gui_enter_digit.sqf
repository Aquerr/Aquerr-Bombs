#include "script_component.hpp"

params["_digit"];

_bomb = GVAR(Bomb_Interface_Target);
_explodeFunction = _bomb getVariable ["aquerr_bomb_explode_function", {}];
_removeBombActionsFunction = _bomb getVariable ["aquerr_bomb_remove_actions_function", {}];
_afterDefuseFunction = _bomb getVariable ["aquerr_bomb_after_defuse_function", {}];

private _isArmed = _bomb getVariable ["aquerr_bomb_is_armed", false];
if (!_isArmed) exitWith {hint LLSTRING(BombAlreadyDefused)};

_newCode = (format  ["%1%2", (_bomb getVariable ["aquerr_bomb_entered_code", ""]), _digit]);
_bomb setVariable ["aquerr_bomb_entered_code", _newCode, true];

hint (format [ LLSTRING(CurrentBombCode) + ": %1", _newCode]);

_solutionCode = _bomb getVariable ["aquerr_bomb_solution_code", ""];
if ((count _newCode) == (count _solutionCode)) then {
    if (_solutionCode isEqualTo _newCode) then {
        [_bomb] call _removeBombActionsFunction;
        _bomb setVariable ["aquerr_bomb_is_armed", false, true];
        hint LLSTRING(BombDefused);
        [_bomb, QGVAR(BombDefuse)] remoteExec ["say3D"];

        _afterDefuseFunction = _bomb getVariable ["aquerr_bomb_after_defuse_function", {}];
        [_bomb, _defuser] call _afterDefuseFunction; 
    } else {
        [_bomb] call _removeBombActionsFunction;
        [_bomb] call _explodeFunction;
    };
};