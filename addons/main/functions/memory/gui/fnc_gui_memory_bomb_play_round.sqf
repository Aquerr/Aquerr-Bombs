#include "..\..\script_component.hpp"

params ["_bomb"];

[_bomb] spawn {
    params ["_bomb"];

    private _buttons = [
        [MEMORY_BOMB_BUTTON_RED_ID, QGVAR(MemoryButton), 0.6], 
        [MEMORY_BOMB_BUTTON_GREEN_ID, QGVAR(MemoryButton), 0.7], 
        [MEMORY_BOMB_BUTTON_BLUE_ID, QGVAR(MemoryButton), 0.8], 
        [MEMORY_BOMB_BUTTON_YELLOW_ID, QGVAR(MemoryButton), 0.9]
    ];

    private _sequence = _bomb getVariable ["aquerr_memory_bomb_sequence", [(floor random 4)]];
    private _round = _bomb getVariable ["aquerr_memory_bomb_round", 1];

    // Add a new random step
    _sequence pushBack (floor random 4);
    _bomb setVariable ["aquerr_memory_bomb_sequence", _sequence];
    _bomb setVariable ["aquerr_memory_bomb_input", []];

    waitUntil {sleep 0.5; (_bomb getVariable ["aquerr_memory_bomb_sequence_showing", false]) == false};

    _bomb setVariable ["aquerr_memory_bomb_sequence_showing", true];
    scopeName "outsideSequence";

    _reshow = false;

    while {true} do {

        if (!dialog) exitWith {
            _bomb setVariable ["aquerr_memory_bomb_sequence_showing", false];
        };

        _sequence = _bomb getVariable ["aquerr_memory_bomb_sequence", []];
        scopeName "insideWhile";
        {
            _input = _bomb getVariable ["aquerr_memory_bomb_input", []];
            if (count _input > 0) then {
                _bomb setVariable ["aquerr_memory_bomb_sequence_showing", false];    
                breakTo "outsideSequence";
            };
            _button = _buttons select _x;
            _control = (findDisplay MEMORY_BOMB_INTERFACE_ID) displayCtrl (_button select 0);
            
            _baseColor = ctrlBackgroundColor _control;
            _control ctrlSetBackgroundColor [1, 1, 1, 1]; // Flash white
            
            _sound = _button select 1;
            _pitch = _button select 2;
            playSoundUI [_sound, 1, _pitch];
            sleep 0.4;
            _control ctrlSetBackgroundColor _baseColor; // Reset
            sleep 0.5;

            _reshow = true;
            
        } forEach _sequence;

        sleep 5;
    };

    _bomb setVariable ["aquerr_memory_bomb_sequence_showing", false];
};