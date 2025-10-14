#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Displays keypad's backpanel. Local only.

	Parameter(s):
        0: OBJECT - the object that keypad is attached to

	Example:
        [2] call abombs_main_fnc_gui_keypad_view_back_panel;
*/

params ["_object", "_back_panel_interface_dialog_name"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Interface_Target) = _object;

[_object, _back_panel_interface_dialog_name] spawn {
    params ["_object", "_back_panel_interface_dialog_name"];

    waitUntil {not dialog};
    waitUntil {createDialog _back_panel_interface_dialog_name};

    _dialog = findDisplay CLASSIC_KEYPAD_INTERFACE_BACK_PANEL_ID;

    _serialNumberField = _dialog displayCtrl BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
    _serialNumberField ctrlSetText ("S\N: " + (_object getVariable ["aquerr_bomb_serial_number","####"]));
};
