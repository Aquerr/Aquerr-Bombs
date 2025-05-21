#include "..\..\script_component.hpp"

params ["_bomb"];

_bomb setVariable ["aquerr_memory_bomb_sequence", []];
_bomb setVariable ["aquerr_memory_bomb_input", []];
_bomb setVariable ["aquerr_memory_bomb_round", 1];

// Start the first round
[_bomb] spawn {
    params ["_bomb"];

    sleep 1;
    [_bomb] call FUNC(gui_memory_bomb_play_round);
};