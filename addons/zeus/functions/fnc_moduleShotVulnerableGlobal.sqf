#include "script_component.hpp"

params [["_objectClassNames", [], [[]]], "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

TRACE_1("_objectClassNames",str _objectClassNames);
[_objectClassNames, _shouldDeleteWreckAfterExplosion, _explosionClassName] call EFUNC(main,register_explosive_handlers_global);
[LLSTRING(ObjectIsNowVulnerableToShots)] call FUNC(showZeusFeedbackMessage);