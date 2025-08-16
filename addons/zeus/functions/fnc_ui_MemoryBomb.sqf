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
    [_msg] call FUNC(showZeusFeedbackMessage);
    breakOut "Main";
};

switch (false) do {
    case !(isNull _unit): {
        [LELSTRING(common,MustSelectObject)] call _fnc_errorAndClose;
    };
};

if (isNil QGVAR(ExplosionClassNames)) then {
    GVAR(ExplosionClassNames) = ("(getText (_x >> 'explosionType') in ['bomb', 'explosive']) && (getNumber (_x >> 'hit') > 0) && (count ([_x] call BIS_fnc_returnParents) > 2)" configClasses (configFile >> "cfgAmmo")) apply { configName _x };
};

private _bombTimeEditField = _display displayCtrl ZEUS_COMMON_DIALOG_BOMB_TIME_ID;
private _shouldBeepToggleField = _display displayCtrl ZEUS_COMMON_DIALOG_SHOULD_BEEP_ID;
private _roundsCountEditField = _display displayCtrl ZEUS_MEMORY_BOMB_DIALOG_ROUNDS_COUNT_ID;
private _serialCodeEditField = _display displayCtrl ZEUS_COMMON_DIALOG_SERIAL_NUMBER_ID;
private _explosionClassNameCombo = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;
private _maxDefuseAttempts = _display displayCtrl ZEUS_COMMON_DIALOG_MAX_DEFUSE_ATTEMPTS_ID;
private _removeShotVulnerabilityAfterDefuse = _display displayCtrl ZEUS_COMMON_DIALOG_REMOVE_SHOT_VULNERABILITY_AFTER_DEFUSE_ID;
private _requireEODToggleField = _display displayCtrl ZEUS_COMMON_DIALOG_REQUIRE_EOD_ID;
private _requiredDefusalItemsEditField = _display displayCtrl ZEUS_COMMON_DIALOG_REQUIRED_DEFUSAL_ITEMS_EDIT_ID;

////////////////////////////////////////////////////////////
// Default values
_bombTimeEditField ctrlSetText "60";
_shouldBeepToggleField lbSetCurSel 1;
_roundsCountEditField ctrlSetText "5";
_serialCodeEditField ctrlSetText "Unknown";
{
    _explosionClassNameCombo lbAdd _x;
} forEach GVAR(ExplosionClassNames);
_explosionClassNameCombo lbSetCurSel 2;
_maxDefuseAttempts ctrlSetText "1";
_removeShotVulnerabilityAfterDefuse lbSetCurSel 0;
_requireEODToggleField lbSetCurSel 0;
_requiredDefusalItemsEditField ctrlSetText "[]";

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

    private _bombTime = parseNumber (ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_BOMB_TIME_ID));
    private _shouldBeep = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_SHOULD_BEEP_ID) > 0;
    private _roundsCount = parseNumber (ctrlText(_display displayCtrl ZEUS_MEMORY_BOMB_DIALOG_ROUNDS_COUNT_ID));
    private _serialNumber = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_SERIAL_NUMBER_ID);
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID);
    private _explosionClassName = (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID);
    private _maxDefuseAttempts = parseNumber (ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_MAX_DEFUSE_ATTEMPTS_ID));
    private _removeShotVulnerabilityAfterDefuse = (lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_REMOVE_SHOT_VULNERABILITY_AFTER_DEFUSE_ID)) > 0;
    private _requireEOD = (lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_REQUIRE_EOD_ID)) > 0;
    private _requiredDefusalItems = parseSimpleArray (ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_REQUIRED_DEFUSAL_ITEMS_EDIT_ID));

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    [attachedTo _logic, _bombTime, _shouldBeep, _roundsCount, _maxDefuseAttempts, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber, _requireEOD, _requiredDefusalItems] call FUNC(moduleMemoryBomb);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
