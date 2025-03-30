#include "script_component.hpp"

params ["_object", "_bombTime", "_solutionCode", "_shouldBeep", "_explosionClassName", "_serialNumber"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LSTRING(MustSelectObject)] call FUNC(showMessage);
} else {
    [_object, _bombTime, _solutionCode, _shouldBeep, _explosionClassName, _serialNumber] call FUNC(scroll_action_keypad_bomb);
    [objNull, "Bomb created!"] call BIS_fnc_showCuratorFeedbackMessage;
};