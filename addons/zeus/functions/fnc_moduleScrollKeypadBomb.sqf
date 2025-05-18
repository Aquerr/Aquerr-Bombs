#include "script_component.hpp"

params ["_object", "_bombTime", "_solutionCode", "_shouldBeep", "_explosionClassName", "_serialNumber"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _solutionCode, _shouldBeep, _explosionClassName, _serialNumber] call EFUNC(main,init_keypad_bomb);
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};