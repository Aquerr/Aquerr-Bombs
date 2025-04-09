#include "script_component.hpp"

params ["_object", "_bombTime", "_solutionCode", "_shouldBeep", "_explosionClassName", "_serialNumber"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showMessage);
} else {
    [_object, _bombTime, _solutionCode, _shouldBeep, _explosionClassName, _serialNumber] call EFUNC(main,scroll_action_keypad_bomb);
    [objNull, LLSTRING(BombCreated)] call BIS_fnc_showCuratorFeedbackMessage;
};