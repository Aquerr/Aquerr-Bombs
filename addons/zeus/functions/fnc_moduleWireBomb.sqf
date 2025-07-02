#include "script_component.hpp"

params ["_object", "_bombTime", "_shouldBeep", "_wireSign", "_wireCount", "_maxDefuseAttempts", "_explosionClassName", "_removeShotVulnerabilityAfterDefuse"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _shouldBeep, _wireSign, _wireCount, _maxDefuseAttempts, _explosionClassName, _removeShotVulnerabilityAfterDefuse] remoteExec [QEFUNC(main,init_wire_bomb_full), 2];
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};
