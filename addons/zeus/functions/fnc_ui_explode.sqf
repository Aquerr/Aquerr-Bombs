#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1; // IDC_OK
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _fnc_onSliderMove = {
    params ["_slider"];

    private _display = ctrlParent _slider;
    (_display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_EDIT_ID) ctrlSetText (str round sliderPosition _slider);
};

if (isNil QGVAR(ExplosionClassNames)) then {
    GVAR(ExplosionClassNames) = ("(getText (_x >> 'explosionType') in ['bomb', 'explosive']) && (getNumber (_x >> 'hit') > 0) && (count ([_x] call BIS_fnc_returnParents) > 2)" configClasses (configFile >> "cfgAmmo")) apply { configName _x };
};

private _delaySlider = _display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_SLIDER_ID;
private _delayEdit = _display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_EDIT_ID;
private _shouldDeleteWreckAfterExplosionToggle = _display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
private _explosionClassNameCombo = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;
private _overrideExplosionClassName = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID;

////////////////////////////////////////////////////////////
// Setup controls
_delaySlider sliderSetRange [0, 120]; // Max 2 minutes delay
_delaySlider sliderSetSpeed [1, 1];
{
    _explosionClassNameCombo lbAdd _x;
} forEach GVAR(ExplosionClassNames);
_delaySlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderMove];

// Default values
_delaySlider sliderSetPosition (uiNamespace getVariable ["abombs_zeus_explode_last_delay", 0]);
_shouldDeleteWreckAfterExplosionToggle lbSetCurSel (uiNamespace getVariable ["abombs_zeus_explode_last_shouldDeleteWreckAfterExplosionIndex", 0]);
_explosionClassNameCombo lbSetCurSel (uiNamespace getVariable ["abombs_zeus_explode_last_explosionClassNameIndex", 0]);
_overrideExplosionClassName ctrlSetText (uiNamespace getVariable ["abombs_zeus_explode_last_overrideExplosionClassName", ""]);

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

    //TODO: Remember last used settings.
    private _delay = round sliderPosition (_display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_SLIDER_ID);
    private _shouldDeleteWreckAfterExplosionIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID);
    private _shouldDeleteWreckAfterExplosion = _shouldDeleteWreckAfterExplosionIndex > 0;
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID);
    private _explosionClassName = (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID);

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    // Save last settings
    uiNamespace setVariable ["abombs_zeus_explode_last_delay", _delay];
    uiNamespace setVariable ["abombs_zeus_explode_last_shouldDeleteWreckAfterExplosionIndex", _shouldDeleteWreckAfterExplosionIndex];
    uiNamespace setVariable ["abombs_zeus_explode_last_explosionClassNameIndex", _explosionClassNameIndex];
    uiNamespace setVariable ["abombs_zeus_explode_last_overrideExplosionClassName", _overrideExplosionClassName];

    // Execute module
    private _objectOrPosition = attachedTo _logic;
    if (_objectOrPosition isEqualTo objNull) then {
        _objectOrPosition = getPosATL _logic;
    };
    
    [_objectOrPosition, _delay, _shouldDeleteWreckAfterExplosion, _explosionClassName] call FUNC(moduleExplode);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
