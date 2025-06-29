#include "script_component.hpp"

params ["_object", "_bombTime", "_solutionCode", "_maxDefuseAttempts", "_shouldBeep", "_explosionClassName", "_removeShotVulnerabilityAfterDefuse", "_serialNumber", "_guiType"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(common,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _bombTime, _solutionCode, _maxDefuseAttempts, _shouldBeep, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber, _guiType] call EFUNC(main,init_keypad_bomb_full);
    [LLSTRING(BombCreated)] call FUNC(showZeusFeedbackMessage);
};