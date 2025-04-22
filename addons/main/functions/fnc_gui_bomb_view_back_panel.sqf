#include "script_component.hpp"

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Bomb_Interface_Target) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Simple_Keypad_Bomb_Interface_Back_Panel_Dialog)};

    _dialog = findDisplay SIMPLE_KEYPAD_BOMB_INTERFACE_BACK_PANEL_ID;

    _serialNumberField = _dialog displayCtrl BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
    _serialNumberField ctrlSetText ("S\N: " + (_bomb getVariable ["aquerr_bomb_serial_number","####"]));
};