#include "script_component.hpp"

params ["_object", "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _shouldDeleteWreckAfterExplosion, _explosionClassName] remoteExec [QEFUNC(main,register_explosive_handlers_for_object), 2];
    [LLSTRING(ObjectIsNowVulnerableToShots)] call FUNC(showZeusFeedbackMessage);
};
