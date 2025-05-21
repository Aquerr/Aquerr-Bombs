#include "script_component.hpp"

params ["_object", "_bombTime", "_shouldBeep", "_wireSign", "_wireCount", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _shouldBeep, _wireSign, _wireCount, _explosionClassName] call EFUNC(main,init_wire_bomb_full);
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};