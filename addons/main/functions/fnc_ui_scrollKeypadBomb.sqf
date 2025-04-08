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
        [LLSTRING(MustSelectObject)] call _fnc_errorAndClose;
    };
};

private _bombTimeEditField = _display displayCtrl 66312;
private _solutionCodeEditField = _display displayCtrl 66314;
private _serialCodeEditField = _display displayCtrl 66315;
private _explosionClassNameCombo = _display displayCtrl 66216;

////////////////////////////////////////////////////////////
// Default values
_bombTimeEditField ctrlSetText "60";
_solutionCodeEditField ctrlSetText "000000";
_serialCodeEditField ctrlSetText "Unknown";
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

    private _bombTime = parseNumber (ctrlText(_display displayCtrl 66312));
    private _shouldBeep = lbCurSel (_display displayCtrl 66313) > 0;
    private _solutionCode = ctrlText (_display displayCtrl 66314);
    private _serialNumber = ctrlText (_display displayCtrl 66315);
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl 66216);
    private _explosionClassName = (_display displayCtrl 66216) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl 66217);

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    [attachedTo _logic, _bombTime, _solutionCode, _shouldBeep, _explosionClassName, _serialNumber] call FUNC(moduleScrollKeypadBomb);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];