#include "script_component.hpp"

params ["_object", "_delay", "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

[_object, _delay, _explosionClassName, _shouldDeleteWreckAfterExplosion] spawn {
    params ["_object", "_delay", "_explosionClassName", "_shouldDeleteWreckAfterExplosion"];
    sleep _delay;
    [_object, _explosionClassName, _shouldDeleteWreckAfterExplosion] call EFUNC(main,explode);
};
