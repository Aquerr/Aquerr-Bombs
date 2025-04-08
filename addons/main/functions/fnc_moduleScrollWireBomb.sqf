#include "script_component.hpp"

params ["_object", "_bombTime", "_shouldBeep", "_wireSign", "_wireCount", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LLSTRING(MustSelectObject)] call FUNC(showMessage);
} else {
    [_object, _bombTime, _shouldBeep, _wireSign, _wireCount, _explosionClassName] call FUNC(scroll_action_bomb_hint_text_image);
    [objNull, LLSTRING(BombCreated)] call BIS_fnc_showCuratorFeedbackMessage;
};