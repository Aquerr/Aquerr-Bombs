#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Open's standard keypad GUI Dialog and setups its fields.

	Parameter(s):
        0: OBJECT - the object that keypad is attached to

	Example:
        [2] call abombs_main_fnc_open_keypad_bomb_interface;
*/

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

_guiType = _bomb getVariable ["aquerr_keypad_bomb_gui_type", "UNKNOWN"];
if (not(_guiType isEqualTo "STANDARD")) exitWith { hint "Unsupported GUI type! Have mission maker setup bomb correctly?" }; 

GVAR(Interface_Target_Object) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Keypad_Bomb_Interface_Dialog)};

    _dialog = findDisplay KEYPAD_BOMB_INTERFACE_ID;

    // Refresh bomb solution code display and timer
    [
        {
            params ["_args", "_handle"];
            _args params ["_dialog", "_bomb"];

            if (isNull _dialog) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            _solutionCodeDisplayField = _dialog displayCtrl BOMB_GUI_ENTERED_CODE_FIELD_ID;
            _solutionCodeDisplayField ctrlSetText (_bomb getVariable ["abombs_keypad_entered_code", ""]);


            _secondsLeft = _bomb getVariable ["abombs_bomb_time_seconds", 0];
            _timeLeftFormatted = [_secondsLeft, "MM:SS"] call BIS_fnc_secondsToString;
            _timeLeftLabel = _dialog displayCtrl BOMB_GUI_TIME_LABEL_ID;
            _timeLeftLabel ctrlSetText _timeLeftFormatted;
        }
    , 0.25, [_dialog, _bomb]] call CBA_fnc_addPerFrameHandler;

};
