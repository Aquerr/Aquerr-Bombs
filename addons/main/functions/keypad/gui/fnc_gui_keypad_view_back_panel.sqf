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

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Interface_Target_Object) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Keypad_Bomb_Interface_Back_Panel_Dialog)};

    _dialog = findDisplay KEYPAD_BOMB_INTERFACE_BACK_PANEL_ID;

    _serialNumberField = _dialog displayCtrl BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
    _serialNumberField ctrlSetText ("S\N: " + (_bomb getVariable ["aquerr_bomb_serial_number","####"]));
};
