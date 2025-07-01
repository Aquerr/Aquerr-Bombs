#include "..\..\script_component.hpp"

params ["_bomb"];

private _isArmed = _bomb getVariable ["abombs_bomb_is_armed", false];
if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

// ============= PREPARATION ===============

// Create dictionary only once and only when at least one morse bomb is used.
if (isNil "abombsMorseCodeDictionary") then {
    abombsMorseCodeDictionary = createHashMapFromArray [
        ["A", [1, 2]], 
        ["B", [2, 1, 1, 1]], 
        ["C", [2, 1, 2, 1]],
        ["D", [2, 1, 1]],
        ["E", [1]],
        ["F", [1, 1, 2, 1]],
        ["G", [2, 2, 1]],
        ["H", [1, 1, 1, 1]],
        ["I", [1, 1]],
        ["J", [1, 2, 2, 2]],
        ["K", [2, 1, 2]],
        ["L", [1, 2, 1, 1]],
        ["M", [2, 2]],
        ["N", [2, 1]],
        ["O", [2, 2, 2]],
        ["P", [1, 2, 2, 1]],
        ["Q", [2, 2, 1, 2]],
        ["R", [1, 2, 1]],
        ["S", [1, 1, 1]],
        ["T", [2]],
        ["U", [1, 1, 2]],
        ["V", [1, 1, 1, 2]],
        ["W", [1, 2, 2]],
        ["X", [2, 1, 1, 2]],
        ["Y", [2, 1, 2, 2]],
        ["Z", [2, 2, 1, 1]],
        
        ["1", [1, 2, 2, 2, 2]],
        ["2", [1, 1, 2, 2, 2]],
        ["3", [1, 1, 1, 2, 2]],
        ["4", [1, 1, 1, 1, 2]],
        ["5", [1, 1, 1, 1, 1]],
        ["6", [2, 1, 1, 1, 1]],
        ["7", [2, 2, 1, 1, 1]],
        ["8", [2, 2, 2, 1, 1]],
        ["9", [2, 2, 2, 2, 1]],
        ["0", [2, 2, 2, 2, 2]]
    ];
};

_encodedMessage = _bomb getVariable ["aquerr_morse_bomb_encoded_message", ""];
_encodedCharacters = toArray _encodedMessage apply {toUpperANSI(toString [_x])};

// =================== RUN ==================

// Start after 2 seconds.
_bomb setVariable ["aquerr_morse_bomb_sequence_showing", true];

_lampControl = (findDisplay MORSE_BOMB_INTERFACE_ID) displayCtrl MORSE_BOMB_LAMP_ID;

{
    if (!dialog) exitWith {
        _bomb setVariable ["aquerr_morse_bomb_sequence_showing", false];
    };

    _character = _x;

    // Special handling for spaces/whitespace.
    if (_character isEqualTo " ") then {
        sleep 2;
        continue;
    };

    _characterMorseCode = abombsMorseCodeDictionary getOrDefault [_character, []];
    if ((count _characterMorseCode) == 0) exitWith {
        hint format ["Wrong bomb configuration. Character %1 does not exist in Morse dictionary!", _character];
    };

    {
        _beepLength = _x;

        private _soundOffset = 0;
        if (_beepLength == 1) then {
            _soundOffset = 0.2;
        };

        private _soundId = playSoundUI [QGVAR(BombMorseBeep), 1, 1, true, _soundOffset];
        private _baseColor = ctrlBackgroundColor _lampControl;
        _lampControl ctrlSetBackgroundColor [1, 1, 1, 1]; // Flash white
        
        waitUntil { (soundParams _soundId) isEqualTo []};
        
        _lampControl ctrlSetBackgroundColor _baseColor; // Reset
        sleep 0.2;
    }
    forEach _characterMorseCode;
    sleep 0.5;
}
forEach _encodedCharacters;

sleep 10;

[_bomb] call FUNC(gui_morse_bomb_start);