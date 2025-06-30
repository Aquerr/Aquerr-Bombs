#include "script_component.hpp"

params ["_object"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object] remoteExec [QEFUNC(main,unregister_explosive_handlers)];
    [LLSTRING(ObjectIsNoLongerVulnerableToShots)] call FUNC(showZeusFeedbackMessage);
};