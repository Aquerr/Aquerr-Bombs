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

private _delaySlider = _display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_SLIDER_ID;
private _delayEdit = _display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_EDIT_ID;
private _shouldDeleteWreckAfterExplosionToggle = _display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
private _explosionClassNameCombo = _display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;

////////////////////////////////////////////////////////////
// Default values
_delaySlider sliderSetRange [0, 120]; // Max 2 minutes delay
_delaySlider sliderSetSpeed [1, 1];
_delaySlider sliderSetPosition 0;
_delayEdit ctrlSetText "0";
_shouldDeleteWreckAfterExplosionToggle lbSetCurSel 0;
_explosionClassNameCombo lbSetCurSel 3;

_delaySlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderMove];

/////////////////////////////////////////////////////////////
// Cancel and Confirmation
private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    //TODO: Remember last used settings.
    private _delay = round sliderPosition (_display displayCtrl ZEUS_EXPLODE_DIALOG_DELAY_SLIDER_ID);
    private _shouldDeleteWreckAfterExplosion = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID) > 0;
    private _explosionClassNameIndex = lbCurSel (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID);
    private _explosionClassName = (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID) lbText _explosionClassNameIndex;
    private _overrideExplosionClassName = ctrlText (_display displayCtrl ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID);

    if (not(_overrideExplosionClassName isEqualTo "")) then {
        _explosionClassName = _overrideExplosionClassName;
    };

    private _object = attachedTo _logic;
    if (_object isEqualTo objNull) then {
        _object = _logic;
    } else {
        deleteVehicle _logic;
    };
    
    //TODO: Ability to pass position to the module and explode function + remove _logic 
    [_object, _delay, _shouldDeleteWreckAfterExplosion, _explosionClassName] call FUNC(moduleExplode);

    //TODO: Remove this
    if (_logic isNotEqualTo objNull) then {
        [_logic] spawn {
            params ["_logic"];
            sleep 120;
            deleteVehicle _logic;
        };
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
