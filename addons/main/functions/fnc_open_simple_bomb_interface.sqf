#include "script_component.hpp"

params ["_bomb"];

if (dialog) then {
    closeDialog 0;
};

//TODO: If bomb is other than keypad then return and show info about unsupported interface.

GVAR(Bomb_Interface_Target) = _bomb;

[_bomb] spawn {
    params ["_bomb"];

    waitUntil {not dialog};
    waitUntil {createDialog QGVAR(Simple_Keypad_Bomb_Interface_Dialog)};

    _dialog = findDisplay SIMPLE_KEYPAD_BOMB_INTERFACE_ID;

    // Refresh bomb solution code display
    [
        {
            params ["_args", "_handle"];
            _args params ["_dialog", "_bomb"];

            if (isNull _dialog) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            _solutionCodeDisplayField = _dialog displayCtrl BOMB_GUI_ENTERED_CODE_FIELD_ID;
            _solutionCodeDisplayField ctrlSetText (_bomb getVariable ["aquerr_bomb_entered_code", ""]);
        }
    , 0.25, [_dialog, _bomb]] call CBA_fnc_addPerFrameHandler;

};