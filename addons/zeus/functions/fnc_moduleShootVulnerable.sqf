#include "script_component.hpp"

params ["_object", "_shouldDeleteWreckAfterExplosion"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showMessage);
} else {
    [_object, _shouldDeleteWreckAfterExplosion] call EFUNC(main,register_explosive_handlers_for_object);
    [objNull, LLSTRING(ObjectIsNowVulnerableToShots)] call BIS_fnc_showCuratorFeedbackMessage;
};