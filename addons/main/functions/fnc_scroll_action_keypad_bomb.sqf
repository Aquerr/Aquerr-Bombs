#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
		Script for simple action based digit system for bomb defusal.

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

	Example:
		[_myBombThing, 60, "2454"] execVM 'scroll_action_keypad_bomb.sqf';
		[_myBombThing, 0, "123", true, "GrenadeHand"] execVM 'scroll_action_keypad_bomb.sqf';
        [_myBombThing, 0, "123", true, "DemoCharge_Remote_Ammo"] execVM 'scroll_action_keypad_bomb.sqf';
*/

params ["_device", ["_timeSeconds", 60, [0]], ["_solutionCode", "0000", ["string"]], ["_shouldBeep", true, [true]], ["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]], ["_serialNumber", "", ["string"]]];

private _removeBombActionsFunction = {
    params ["_device"];

    _actionIds = _device getVariable ["aquerr_bomb_action_ids", []];
    {
        _device removeAction _x;
    } forEach _actionIds;
};

private _bombTimerFunction = {
    params ["_device", "_explodeFunction", "_removeBombActionsFunction"];

    [_device, _explodeFunction, _removeBombActionsFunction] spawn {
        params ["_device", "_explodeFunction", "_removeBombActionsFunction"];

        private _timeLeft = (_device getVariable ["aquerr_bomb_time_seconds", 0]);
        private _fakeTimer = false;
        if (_timeLeft == 0) then {
            _fakeTimer = true;
        };

        while {true} do {

            if(!alive _device) exitWith {
                0;
            };

            if (!(_device getVariable ["aquerr_bomb_is_armed", false])) exitWith {
                0;
            };

            sleep 1;

            if (!(_fakeTimer)) then {
                  if (_timeLeft <= 0) exitWith {
                      call _removeBombActionsFunction;
                      call _explodeFunction;
                  };
                _timeLeft = _timeLeft - 1;
                _device setVariable ["aquerr_bomb_time_seconds", _timeLeft, true];
            };

            _shouldBeep = _device getVariable ["aquerr_bomb_beep_enabled", false];
            if (_shouldBeep) then {
               [_device, QGVAR(BombBeep)] remoteExec ["say3D"];
            };
        };
    };
};

 private _explodeFunction = {
    params ["_device"];

    // VERY_BIG = "ammo_Missile_Cruise_01"
    // BIG = "helicopterExploBig"
    // MEDIUM = "DemoCharge_Remote_Ammo"
    // SMALL = "APERSMine_Range_Ammo"

    _explosionClassName = _device getVariable ["aquerr_bomb_explosion_class_name", "DemoCharge_Remote_Ammo"];
    _explosive = _explosionClassName createVehicle (getPos _device);
    deleteVehicle _device;
    _explosive setDamage 1;
 };

 private _enterDigitFunction = {
    params ["_device", "_digit", "_explodeFunction", "_removeBombActionsFunction"];

    private _isArmed = _device getVariable ["aquerr_bomb_is_armed", false];
    if (!_isArmed) exitWith {hint LLSTRING(BombAlreadyDefused)};

    _newCode = (format  ["%1%2", (_device getVariable ["aquerr_bomb_entered_code", ""]), _digit]);
    _device setVariable ["aquerr_bomb_entered_code", _newCode, true];

    hint (format [ LLSTRING(CurrentBombCode) + ": %1", _newCode]);

    _solutionCode = _device getVariable ["aquerr_bomb_solution_code", ""];
    if ((count _newCode) == (count _solutionCode)) then {
        if (_solutionCode isEqualTo _newCode) then {
            call _removeBombActionsFunction;
            _device setVariable ["aquerr_bomb_is_armed", false, true];
            hint LLSTRING(BombDefused);
            [_device, QGVAR(BombDefuse)] remoteExec ["say3D"];
        } else {
            call _removeBombActionsFunction;
            call _explodeFunction;
        };
    };
 };

 private _prepareDigitActionFunction = {
        params ["_device", "_digit", "_enterDigitFunction", "_explodeFunction", "_removeBombActionsFunction"];

        _action = [(format ["number_%1", _digit]), _digit, "",
        {
            params ["_target", "_player", "_actionParams"];
            _digit = _actionParams select 0;
            _enterDigitFunction = _actionParams select 1;
            _explodeFunction = _actionParams select 2;
            _removeBombActionsFunction = _actionParams select 3;
            [_target, _digit, _explodeFunction, _removeBombActionsFunction] call _enterDigitFunction;

        }, {true}, {}, [_digit, _enterDigitFunction, _explodeFunction, _removeBombActionsFunction, _enterDigitFunction]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;

        _device addAction
        [
            "<t color='#FF0000'>" + _digit + "</t>",	// title
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // script

                _digit = _arguments select 0;
                _enterDigitFunction = _arguments select 1;
                _explodeFunction = _arguments select 2;
                _removeBombActionsFunction = _arguments select 3;
                [_target, _digit, _explodeFunction, _removeBombActionsFunction] call _enterDigitFunction;
            },
            [_digit, _enterDigitFunction, _explodeFunction, _removeBombActionsFunction],		// arguments
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
            params ["_device"];

            _device setVariable ["aquerr_bomb_entered_code", "", true];
            hint LLSTRING(CodeCleared);
        };

        _action = ["code_clear", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_clearCodeFunction]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;

        _device addAction
        [
            format ["<t color='#00FF00'>%1</t>", _actionName],	// title
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // script
                [_target] call (_arguments select 0);
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

 private _prepareActionsFunction = {
        params ["_device", "_enterDigitFunction", "_prepareDigitActionFunction", "_prepareClearCodeFunction", "_explodeFunction", "_removeBombActionsFunction", "_prepareCheckTimeFunction", "_prepareCheckSerialNumberFunction"];

        _actionParent = ["aquerr_bomb_keypad", LLSTRING(AceMenuBombKeyboard), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_device, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;
        _actionParent = ["aquerr_bomb_back", LLSTRING(AceMenuBombBack), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_device, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;

        _bombActionIds = [];
        _bombActionIds pushBack ([_device, LLSTRING(CheckBombTime)] call _prepareCheckTimeFunction);
        _bombActionIds pushBack ([_device, LLSTRING(ClearBombCode)] call _prepareClearCodeFunction);
        _bombActionIds pushBack ([_device, LLSTRING(CheckBombSerialNumber)] call _prepareCheckSerialNumberFunction);
        _bombActionIds pushBack ([_device, "0", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "1", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "2", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "3", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "4", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "5", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "6", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "7", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "8", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);
        _bombActionIds pushBack ([_device, "9", _enterDigitFunction, _explodeFunction, _removeBombActionsFunction] call _prepareDigitActionFunction);

        _device setVariable ["aquerr_bomb_action_ids", _bombActionIds, clientOwner];
 };

 private _prepareServerVariablesFunction = {
     params ["_solutionCode", "_timeSeconds", "_explosionClassName", "_shouldBeep", "_serialNumber"];

     _device setVariable ["aquerr_bomb_solution_code", _solutionCode, true];
     _device setVariable ["aquerr_bomb_is_armed", true, true];
     _device setVariable ["aquerr_bomb_time_seconds", _timeSeconds, true];
     _device setVariable ["aquerr_bomb_entered_code", "", true];
     _device setVariable ["aquerr_bomb_explosion_class_name", _explosionClassName, true];
     _device setVariable ["aquerr_bomb_beep_enabled", _shouldBeep, true];
     _device setVariable ["aquerr_bomb_serial_number", _serialNumber, true];
 };

 private _prepareClientVariablesFunction = {
    params [];

    SETVAR(_device,aquerr_wire_bomb_interface_initialized,true);
 };

 private _registerEventHandlersFunction = {
    params ["_device"];

    _device addEventHandler ["HitPart", {
        (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

        _explosionClassName = _target getVariable ["aquerr_bomb_explosion_class_name", "DemoCharge_Remote_Ammo"];
        _explosive = createVehicle [_explosionClassName, (getPos _target), [], 0, "CAN_COLLIDE"];
        deleteVehicle _target;
        _explosive setDamage 1;
    }];

    _device addEventHandler ["Explosion", {
        params ["_vehicle", "_damage", "_source"];
        if (_vehicle getVariable ["already_exploded", 0] == 1) exitWith {};
        _vehicle setVariable ["already_exploded", 1];

        _explosionClassName = _vehicle getVariable ["aquerr_bomb_explosion_class_name", "DemoCharge_Remote_Ammo"];
        _explosive = createVehicle [_explosionClassName, (getPos _vehicle), [], 0, "CAN_COLLIDE"];
        deleteVehicle _vehicle;
        _explosive setDamage 1;
    }];
 };

if (isServer) then {

    if (_device getVariable ["aquerr_bomb_is_armed", false]) exitWith {hint "Bomba jest już uzbrojona!";};

    [_solutionCode, _timeSeconds, _explosionClassName, _shouldBeep, _serialNumber] call _prepareServerVariablesFunction;
    [_device, _explodeFunction, _removeBombActionsFunction] call _bombTimerFunction;
};

if (hasInterface) then {

    if (GETVAR(_device,aquerr_wire_bomb_interface_initialized,false)) exitWith {};

    [] call _prepareClientVariablesFunction;
    [_device, _enterDigitFunction, _prepareDigitActionFunction, _prepareClearCodeFunction, _explodeFunction, _removeBombActionsFunction, _prepareCheckTimeFunction, _prepareCheckSerialNumberFunction] call _prepareActionsFunction;
    [_device] call _registerEventHandlersFunction;
};