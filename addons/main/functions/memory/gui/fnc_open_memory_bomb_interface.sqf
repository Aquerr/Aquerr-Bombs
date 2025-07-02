#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Open's memory bomb GUI Dialog and setups its fields.

	Parameter(s):
        0: OBJECT - the object that bomb is attached to

	Example:
        [2] call abombs_main_fnc_open_memory_bomb_interface;
*/

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Bomb_Interface_Target) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Memory_Bomb_Interface_Dialog)};

    _dialog = findDisplay MEMORY_BOMB_INTERFACE_ID;

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

    private _isArmed = _bomb getVariable ["abombs_bomb_is_armed", false];
    if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

    _bomb setVariable ["aquerr_memory_bomb_input", false];
    _bomb setVariable ["aquerr_memory_bomb_sequence_showing", false];
    [_bomb] call FUNC(gui_memory_bomb_start);
};
