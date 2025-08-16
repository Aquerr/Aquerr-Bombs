#include "script_component.hpp"

params [
    "_object", 
    "_bombTime", 
    "_shouldBeep", 
    "_rounds", 
    "_maxDefuseAttempts", 
    "_explosionClassName", 
    "_removeShotVulnerabilityAfterDefuse", 
    "_serialNumber",
    "_requireEOD",
    "_requiredDefusalItems"
];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _shouldBeep, _rounds, _maxDefuseAttempts, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber] remoteExec [QEFUNC(main,init_memory_bomb_full), 2];
    [_object, _requireEOD] call EFUNC(main,set_require_eod);
	[_object, _requiredDefusalItems] call EFUNC(main,set_require_defusal_items);
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};
