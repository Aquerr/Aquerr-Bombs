#include "script_component.hpp"

params ["_logic"];

TRACE_1("Logic Object",_logic);

private _fnc_errorAndClose = {
    params ["_msg"];
    deleteVehicle _logic;
    [_msg] call FUNC(showZeusFeedbackMessage);
    breakOut "Main";
};

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

// Validate module target
private _unit = attachedTo _logic;
TRACE_1("unit",_unit);

scopeName "Main";

switch (false) do {
    case !(isNull _unit): {
        [LELSTRING(common,MustSelectObject)] call _fnc_errorAndClose;
    };
};

// Execute module
[_unit] call FUNC(moduleRemoveShotVulnerable);
[] call _fnc_onUnload;