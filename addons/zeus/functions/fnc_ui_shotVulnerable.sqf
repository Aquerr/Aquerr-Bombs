#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1; // IDC_OK
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

// Validate module target
private _unit = attachedTo _logic;
TRACE_1("unit",_unit);

scopeName "Main";

private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call FUNC(showMessage);
    breakOut "Main";
};

switch (false) do {
    case !(isNull _unit): {
        [LELSTRING(common,MustSelectObject)] call _fnc_errorAndClose;
    };
};

private _shouldDeleteWreckAfterExplosionToggle = _display displayCtrl ZEUS_SHOT_VULNERABLE_OBJECT_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
private _explosionClassNameCombo = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;

////////////////////////////////////////////////////////////
// Default values
_shouldDeleteWreckAfterExplosionToggle lbSetCurSel 0;
_explosionClassNameCombo lbSetCurSel 0;

/////////////////////////////////////////////////////////////
// Cancel and Confirmation
private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _shouldDeleteWreckAfterExplosion = lbCurSel (_display displayCtrl ZEUS_SHOT_VULNERABLE_OBJECT_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID) > 0;
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID);
    private _explosionClassName = (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID);

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    [attachedTo _logic, _shouldDeleteWreckAfterExplosion, _overrideExplosionClassName] call FUNC(moduleShotVulnerable);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];