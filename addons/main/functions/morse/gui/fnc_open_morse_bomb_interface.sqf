#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Open's Morse bomb GUI Dialog and setups its fields.

	Parameter(s):
        0: OBJECT - the object that bomb is attached to

	Example:
        [2] call abombs_main_fnc_open_morse_bomb_interface;
*/

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Bomb_Interface_Target) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Morse_Bomb_Interface_Dialog)};

    _dialog = findDisplay MORSE_BOMB_INTERFACE_ID;

    _serialNumberField = _dialog displayCtrl BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
    _serialNumberField ctrlSetText ("S\N: " + (_bomb getVariable ["aquerr_bomb_serial_number","####"]));

    [
        {
            params ["_args", "_handle"];
            _args params ["_dialog", "_bomb"];

            if (isNull _dialog) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            _secondsLeft = _bomb getVariable ["abombs_bomb_time_seconds", 0];
            _timeLeftFormatted = [_secondsLeft, "MM:SS"] call BIS_fnc_secondsToString;
            _timeLeftLabel = _dialog displayCtrl BOMB_GUI_TIME_LABEL_ID;
            _timeLeftLabel ctrlSetText _timeLeftFormatted;
        }
    , 0.25, [_dialog, _bomb]] call CBA_fnc_addPerFrameHandler;

    _bomb setVariable ["aquerr_morse_bomb_input", false];
    _bomb setVariable ["aquerr_morse_bomb_sequence_showing", false];

    sleep 2;
    [_bomb] call FUNC(gui_morse_bomb_start);
};