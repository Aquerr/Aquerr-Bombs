#include "..\..\script_component.hpp"

params ["_colorPressed"];

[_colorPressed] spawn {
    params ["_colorPressed"];

    _bomb = GVAR(Bomb_Interface_Target);

    private _isArmed = _bomb getVariable ["abombs_bomb_is_armed", false];
    if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

    // Add pressed input
    _bomb setVariable ["aquerr_memory_bomb_input", ((_bomb getVariable ["aquerr_memory_bomb_input", []]) + [_colorPressed])];
    private _input = _bomb getVariable ["aquerr_memory_bomb_input", []];

    private _controlHidden = (findDisplay MEMORY_BOMB_INTERFACE_ID) displayCtrl MEMORY_BOMB_BUTTON_HIDDEN_ID;
    ctrlSetFocus _controlHidden; // Unfocus all colored buttons

    private _sequence = _bomb getVariable ["aquerr_memory_bomb_sequence", []];
    if ((count _sequence) == 0) exitWith {};

    // Check input so far
    private _index = count _input - 1;
    if (_input select _index != _sequence select _index) exitWith {
        _maxDefuseAttempts = _bomb getVariable ["abombs_bomb_max_defuse_attempts", 1];
        _attempts = (_bomb getVariable ["abombs_bomb_defuse_attempts", 0]) + 1;
        _bomb setVariable ["abombs_bomb_defuse_attempts", _attempts, true];
        if (_attempts >= _maxDefuseAttempts) then {
            closeDialog 0;
            [_bomb, player] call FUNC(bomb_explode);
        } else {
            hint "Bomb still ticks...";
            [_bomb] call FUNC(gui_memory_bomb_start);
        };
    };

    // Check if sequence complete
    if (count _input == count _sequence) then {
        if (count _sequence >= (_bomb getVariable ["aquerr_memory_bomb_required_rounds", 5])) then {
            closeDialog 0;
            [_bomb, player] call FUNC(bomb_defuse);
        } else {
            // Next round
            _bomb setVariable ["aquerr_memory_bomb_round", (_bomb getVariable "aquerr_memory_bomb_round") + 1];

            sleep 1;
            [_bomb] call FUNC(gui_memory_bomb_play_round);
        };
    };

};
