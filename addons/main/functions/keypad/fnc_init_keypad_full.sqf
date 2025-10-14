#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for simple keypad.

	Parameter(s):
		0: the thing that the keypad script should be attached to
		1: STRING - the solution code
        2: STRING - the keypad's serial number. Not used by the mod.
        3: CODE - after success function. Executed LOCALLY. Passed parameters are ["_object", "_user"].
        9: BOOL - optional, if the script should be run globally. Can be skipped in most cases.

	Example:
		[_myKeypad, "2454"] call abombs_main_fnc_init_keypad_full;
		[_myKeypad, "123", "AWX-23-CD-12, true] call abombs_main_fnc_init_keypad_full;
        [_myKeypad, "123", "MY_SERIAL_CODE", {hint "DOOR UNLOCKED!";}] call abombs_main_fnc_init_keypad_full;
*/

params [
    "_object", 
    ["_solutionCode", "0000", ["string"]], 
    ["_serialNumber", "", ["string"]], 
    ["_afterSuccessFunction", {}, [{}]], 
    ["_global", true, [true]]
];

if ((isNil "_object") || {isNull(_object)}) exitWith { hint LELSTRING(common,MustSelectObject) };

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(init_keypad_full_JIP)}}}}) exitWith {

    private _id = [QGVAR(init_keypad_full), [_object, _solutionCode, _serialNumber, _afterSuccessFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(init_keypad_full_JIP), _id, true];
};

 private _prepareServerVariablesFunction = {
     params ["_object", "_afterSuccessFunction"];

     _object setVariable ["abombs_object_after_success_function", _afterSuccessFunction, true];
 };

if (isServer) then {
    [_object, _afterSuccessFunction] call _prepareServerVariablesFunction;

    private _failureFunction = {
        params ["_object", "_user"];

        _object setVariable ["abombs_keypad_entered_code", "", true];
        hint (LLSTRING(WrongCode));
        //TODO: Play failure sound
    };

    private _canEnterDigitFunction = {
        params ["_user", "_object", "_digit"];
        true;
    };

    private _canConfirmFunction = {
        params ["_object", "_user"];
        true;
    };

    private _successFunction = {
        params ["_object", "_user"];
        _object setVariable ["abombs_keypad_entered_code", "", true];
        [_object, QGVAR(BombDefuse)] remoteExec ["say3D"];
        _afterSuccessFunction = _object getVariable ["abombs_object_after_success_function", {}];
        [_object, _user] call _afterSuccessFunction;
    };

    _object setVariable ["abombs_keypad_failure_function", _failureFunction, true];
    _object setVariable ["abombs_keypad_can_enter_digit_function", _canEnterDigitFunction, true];
    _object setVariable ["abombs_keypad_can_confirm_function", _canConfirmFunction, true];
    _object setVariable ["abombs_keypad_success_function", _successFunction, true];
    
    [_object, _solutionCode] call FUNC(init_keypad_solution_code);
};

if (hasInterface) then {
    if (GETVAR(_object,aquerr_keypad_interface_initialized,false)) exitWith {};

    private _openGui = {
        params ["_object"];

        [_object] call FUNC(open_classic_keypad_interface);
    };

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = ["open_gui", "View interface", "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_openGui]] call ace_interact_menu_fnc_createAction;

        [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

    _object addAction
    [
        format ["<t color='#00FF00'>%1</t>", "View keypad"],	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            [_target] call (_arguments select 0);
        },
        [_openGui],		// arguments
        1.5,		// priority
        true,		// showWindow
        true,		// hideOnUse
        "",			// shortcut
        "true",		// condition
        3,			// radius
        false,		// unconscious
        "",			// selection
        ""			// memoryPoint
    ];
};

[_object, _serialNumber] call FUNC(init_serial_number);

if (hasInterface) then {
    SETVAR(_object,aquerr_keypad_interface_initialized,true);
};
