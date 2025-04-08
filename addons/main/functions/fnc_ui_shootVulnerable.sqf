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

private _bombTimeEditField = _display displayCtrl 66212;
private _wireEditField = _display displayCtrl 66214;
private _wireCountSlider = _display displayCtrl 66215;
private _wireCountEdit = _display displayCtrl 66220;
private _explosionClassNameCombo = _display displayCtrl 66216;

////////////////////////////////////////////////////////////
// Default values
_bombTimeEditField ctrlSetText "60";
_wireEditField ctrlSetText "|";

_wireCountSlider sliderSetRange [4, 100];
_wireCountSlider sliderSetSpeed [1, 1];
_wireCountSlider sliderSetPosition 10;
_wireCountEdit ctrlSetText "10";

_explosionClassNameCombo lbSetCurSel 0;

_wireCountSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderMove];

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

    private _shouldDeleteWreckAfterExplosion = lbCurSel (_display displayCtrl 66113) > 0;

    [attachedTo _logic, _shouldDeleteWreckAfterExplosion] call FUNC(moduleShootVulnerable);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];