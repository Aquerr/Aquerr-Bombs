#include "script_component.hpp"

params ["_object", "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    _object setVariable ["aquerr_explosion_class_name", _explosionClassName];
    _object setVariable ["aquerr_delete_after_explosion", _shouldDeleteWreckAfterExplosion];
    [_object] remoteExec [QEFUNC(main,explode), 2];
};
