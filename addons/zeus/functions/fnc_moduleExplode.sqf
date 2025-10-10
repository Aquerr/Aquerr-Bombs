#include "script_component.hpp"

params ["_object", "_delay", "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

[
    {
        params ["_objectOrLocation", "_explosionClassName", "_shouldDeleteWreckAfterExplosion"];
        [_objectOrLocation, _explosionClassName, _shouldDeleteWreckAfterExplosion] call EFUNC(main,explode);
    }, 
    [_object, _explosionClassName, _shouldDeleteWreckAfterExplosion], 
    _delay
] 
call CBA_fnc_waitAndExecute;
