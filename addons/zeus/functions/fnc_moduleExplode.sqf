#include "script_component.hpp"

params ["_object", "_delay", "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

_object setVariable ["aquerr_explosion_class_name", _explosionClassName];
_object setVariable ["aquerr_delete_after_explosion", _shouldDeleteWreckAfterExplosion];

[_object, _delay] spawn {
    params ["_object", "_delay"];
    sleep _delay;
    [_object] remoteExec [QEFUNC(main,explode), 2];
};
