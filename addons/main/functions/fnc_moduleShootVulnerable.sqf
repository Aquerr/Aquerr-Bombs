#include "script_component.hpp"

params ["_object", "_shouldDeleteWreckAfterExplosion"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LSTRING(MustSelectObject)] call FUNC(showMessage);
} else {
    [_object, _shouldDeleteWreckAfterExplosion] call FUNC(register_explosive_handlers_for_object);
    [objNull, "Object is now vulnerable to shots!"] call BIS_fnc_showCuratorFeedbackMessage;
};