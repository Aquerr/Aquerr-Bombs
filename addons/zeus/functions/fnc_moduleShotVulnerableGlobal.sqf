#include "script_component.hpp"

params [["_objectClassNames", [], [[]]], "_shouldDeleteWreckAfterExplosion", "_explosionClassName"];

TRACE_1("_objectClassNames",str _objectClassNames);
[_objectClassNames, _shouldDeleteWreckAfterExplosion, _explosionClassName] remoteExec [QEFUNC(main,register_explosive_handlers_global), 2];
[LLSTRING(ObjectIsNowVulnerableToShots)] call FUNC(showZeusFeedbackMessage);
