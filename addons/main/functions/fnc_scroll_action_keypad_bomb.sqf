#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for simple bomb with scroll/ace action keypad.

	Parameter(s):
		0: the thing that the script should be attached to
		1: NUMBER - the bomb time (0 = no time, the bomb will explode only on wrong code)
		2: STRING - the solution code
		3: BOOLEAN - if the boom should beep every second
		4: STRING - the explosion class name to use
            // "ammo_Missile_Cruise_01" (very big)
            // "helicopterExploBig" (big)
            // "DemoCharge_Remote_Ammo" (medium)
            // "APERSMine_Range_Ammo" (small)
        5: STRING - the bombs's serial number. Not used by the mod.
        6: CODE - after defuse function. Executed LOCALLY when bomb is defused. Passed parameters are ["_bomb", "_defuserPlayer"].
        7: BOOL - optional, if the script should be run globally. Can be skipped in most cases.

	Example:
		[_myBombThing, 60, "2454"] call abombs_main_fnc_scroll_action_keypad_bomb;
		[_myBombThing, 0, "123", true, "GrenadeHand"] call abombs_main_fnc_scroll_action_keypad_bomb;
        [_myBombThing, 0, "123", true, "DemoCharge_Remote_Ammo"] call abombs_main_fnc_scroll_action_keypad_bomb;
*/

params ["_device", ["_timeSeconds", 60, [0]], ["_solutionCode", "0000", ["string"]], ["_shouldBeep", true, [true]], ["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]], ["_serialNumber", "", ["string"]], ["_afterDefuseFunction", {}, [{}]], ["_global", true, [true]]];

if ((isNil "_device") || {isNull(_device)}) exitWith { hint LELSTRING(common,MustSelectObject) };

if (_global && {isMultiplayer} && {isNil {_device getVariable QGVAR(scroll_action_keypad_bomb_JIP)}}) exitWith {

    private _id = [QGVAR(scroll_action_keypad_bomb), [_device, _timeSeconds, _solutionCode, _shouldBeep, _explosionClassName, _serialNumber, _afterDefuseFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _device] call CBA_fnc_removeGlobalEventJIP;

    _device setVariable [QGVAR(scroll_action_keypad_bomb_JIP), _id, true];
};

private _clientCleanupFunction = {
    params ["_device"];

    _actionIds = _device getVariable ["aquerr_bomb_action_ids", []];
    {
        _device removeAction _x;
    } forEach _actionIds;
};

private _bombTimerFunction = {
    params ["_bomb", "_clientCleanupFunction"];

    [_bomb, _clientCleanupFunction] spawn {
        params ["_bomb", "_clientCleanupFunction"];

        private _timeLeft = (_bomb getVariable ["aquerr_bomb_time_seconds", 0]);
        private _fakeTimer = false;
        if (_timeLeft == 0) then {
            _fakeTimer = true;
        };

        while {true} do {

            if(!alive _bomb) exitWith {
                0;
            };

            if (!(_bomb getVariable ["aquerr_bomb_is_armed", false])) exitWith {
                0;
            };

            sleep 1;

            if (!(_fakeTimer)) then {
                  if (_timeLeft <= 0) exitWith {
                      call _clientCleanupFunction;
                      [objNull, _bomb] call FUNC(bomb_explode);
                  };
                _timeLeft = _timeLeft - 1;
                _bomb setVariable ["aquerr_bomb_time_seconds", _timeLeft, true];
            };

            _shouldBeep = _bomb getVariable ["aquerr_bomb_beep_enabled", false];
            if (_shouldBeep) then {
               [_bomb, QGVAR(BombBeep)] remoteExec ["say3D"];
            };
        };
    };
};

 private _prepareDigitActionFunction = {
        params ["_device", "_digit"];

        _action = [(format ["number_%1", _digit]), _digit, "",
        {
            params ["_target", "_player", "_actionParams"];
            _digit = _actionParams select 0;
            [_player, _target, _digit] call FUNC(bomb_enter_digit);

        }, {true}, {}, [_digit]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;

        _device addAction
        [
            "<t color='#FF0000'>" + _digit + "</t>",	// title
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // script

                _digit = _arguments select 0;
                [_caller, _target, _digit] call FUNC(bomb_enter_digit);
            },
            [_digit],		// arguments
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

 private _prepareClearCodeFunction = {
        params ["_device", "_actionName"];

        private _clearCodeFunction = {
            params ["_defuser", "_device"];
            [_defuser, _device] call FUNC(bomb_clear_entered_code);
        };

        _action = ["code_clear", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_player, _target] call (_actionParams select 0);

        }, {true}, {}, [_clearCodeFunction]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;

        _device addAction
        [
            format ["<t color='#00FF00'>%1</t>", _actionName],	// title
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // script
                [_caller, _target] call (_arguments select 0);
            },
            [_clearCodeFunction],		// arguments
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

 private _prepareCheckTimeFunction = {
    params ["_device", "_actionName"];

    private _checkTimeFunction = {
        params ["_device"];
        _bombTimeSeconds = _device getVariable ["aquerr_bomb_time_seconds", 0];
        _bombTimeSecondsStr = str _bombTimeSeconds;
        if (_bombTimeSeconds == 0) then {
            _bombTimeSecondsStr = "???";
        };
        hint format[ LLSTRING(BombTime) + ": %1s", _bombTimeSecondsStr];
    };

    _action = ["code_clear", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_checkTimeFunction]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    _device addAction
    [
        format ["<t color='#00FF00'>%1</t>", _actionName],	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            [_target] call (_arguments select 0);
        },
        [_checkTimeFunction],		// arguments
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

 private _prepareCheckSerialNumberFunction = {
    params ["_device", "_actionName"];

    private _checkSerialNumber = {
        params ["_device"];
        _bombSerialNumber = _device getVariable ["aquerr_bomb_serial_number", ""];
        hint format[ LLSTRING(BombSerialNumber) + ": %1", _bombSerialNumber];
    };

    _action = ["check_serial_number", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_checkSerialNumber]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions", "aquerr_bomb_back"], _action] call ace_interact_menu_fnc_addActionToObject;

    _device addAction
    [
        format ["<t color='#00FF00'>%1</t>", _actionName],	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            [_target] call (_arguments select 0);
        },
        [_checkSerialNumber],		// arguments
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

 private _prepareOpenGuiFunction = {
    params ["_device", "_actionName"];

    private _openGui = {
        params ["_device"];
        [_device] call FUNC(open_simple_bomb_interface);
    };

    _action = ["open_gui", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_openGui]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    _device addAction
    [
        format ["<t color='#00FF00'>%1</t>", _actionName],	// title
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

 private _prepareActionsFunction = {
        params ["_device", "_prepareDigitActionFunction", "_prepareClearCodeFunction", "_prepareCheckTimeFunction", "_prepareCheckSerialNumberFunction", "_prepareOpenGuiFunction"];

        _actionParent = ["aquerr_bomb_keypad", LLSTRING(AceMenuBombKeyboard), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_device, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;
        _actionParent = ["aquerr_bomb_back", LLSTRING(AceMenuBombBack), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_device, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;

        _bombActionIds = [];
        _bombActionIds pushBack ([_device, LLSTRING(OpenBombInterface)] call _prepareOpenGuiFunction);
        _bombActionIds pushBack ([_device, LLSTRING(CheckBombTime)] call _prepareCheckTimeFunction);
        _bombActionIds pushBack ([_device, LLSTRING(ClearBombCode)] call _prepareClearCodeFunction);
        _bombActionIds pushBack ([_device, LLSTRING(CheckBombSerialNumber)] call _prepareCheckSerialNumberFunction);
        _bombActionIds pushBack ([_device, "0"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "1"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "2"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "3"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "4"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "5"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "6"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "7"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "8"] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "9"] call _prepareDigitActionFunction);

        _device setVariable ["aquerr_bomb_action_ids", _bombActionIds, clientOwner];
 };

 private _prepareServerVariablesFunction = {
     params ["_solutionCode", "_timeSeconds", "_explosionClassName", "_shouldBeep", "_serialNumber", "_afterDefuseFunction"];

     _device setVariable ["aquerr_bomb_type", "KEYPAD", true];
     _device setVariable ["aquerr_bomb_solution_code", _solutionCode, true];
     _device setVariable ["aquerr_bomb_is_armed", true, true];
     _device setVariable ["aquerr_bomb_time_seconds", _timeSeconds, true];
     _device setVariable ["aquerr_bomb_entered_code", "", true];
     _device setVariable ["aquerr_explosion_class_name", _explosionClassName, true];
     _device setVariable ["aquerr_bomb_beep_enabled", _shouldBeep, true];
     _device setVariable ["aquerr_bomb_serial_number", _serialNumber, true];
     _device setVariable ["aquerr_bomb_after_defuse_function", _afterDefuseFunction, true];
 };

 private _prepareClientVariablesFunction = {
    params ["_clientCleanupFunction"];

    SETVAR(_device,aquerr_wire_bomb_interface_initialized,true);
    SETVAR(_device,aquerr_bomb_client_cleanup_function,_clientCleanupFunction);
 };

 private _registerEventHandlersFunction = {
    params ["_device", "_explosionClassName"];

    [_device, true, _explosionClassName, 2] call FUNC(register_explosive_handlers_for_object);
 };

if (isServer) then {

    if (_device getVariable ["aquerr_bomb_is_armed", false]) exitWith {hint LLSTRING(BombAlreadyArmed);};

    [_solutionCode, _timeSeconds, _explosionClassName, _shouldBeep, _serialNumber, _afterDefuseFunction] call _prepareServerVariablesFunction;
    [_device, _clientCleanupFunction] call _bombTimerFunction;
};

if (hasInterface) then {

    if (GETVAR(_device,aquerr_wire_bomb_interface_initialized,false)) exitWith {};

    [_clientCleanupFunction] call _prepareClientVariablesFunction;
    [_device, _prepareDigitActionFunction, _prepareClearCodeFunction, _prepareCheckTimeFunction, _prepareCheckSerialNumberFunction, _prepareOpenGuiFunction] call _prepareActionsFunction;
    [_device, _explosionClassName] call _registerEventHandlersFunction;
};