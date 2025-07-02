#include "script_component.hpp"

params ["_object", "_bombTime", "_shouldBeep", "_rounds", "_maxDefuseAttempts", "_explosionClassName", "_removeShotVulnerabilityAfterDefuse", "_serialNumber"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _shouldBeep, _rounds, _maxDefuseAttempts, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber] remoteExec [QEFUNC(main,init_memory_bomb_full), 2];
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};
