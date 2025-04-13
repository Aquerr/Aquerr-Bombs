#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1; // IDC_OK
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _classNamesEdit = _display displayCtrl ZEUS_VULNERABLE_OBJECTS_GLOBAL_DIALOG_CLASS_NAMES_ID;
private _shouldDeleteWreckAfterExplosionToggle = _display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
private _explosionClassNameCombo = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;

////////////////////////////////////////////////////////////
// Default values
_classListPreparedValue = '["Land_MetalBarrel_F", "Land_GasTank_02_F", "Barrel1"]';

// If Zeus selected an object then retrieve its class name.
private _unit = attachedTo _logic;
if (!(isNull _unit)) then {
    _classListPreparedValue = format ['["%1"]', typeOf _unit]; 
};

_classNamesEdit ctrlSetText _classListPreparedValue;
_shouldDeleteWreckAfterExplosionToggle lbSetCurSel 1;
_explosionClassNameCombo lbSetCurSel 3;

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

    private _classNamesEdit = parseSimpleArray (ctrlText (_display displayCtrl ZEUS_VULNERABLE_OBJECTS_GLOBAL_DIALOG_CLASS_NAMES_ID));
    private _shouldDeleteWreckAfterExplosion = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID) > 0;
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID);
    private _explosionClassName = (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID);

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    [_classNamesEdit, _shouldDeleteWreckAfterExplosion, _explosionClassName] call FUNC(moduleShotVulnerableGlobal);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];