#include "..\script_component.hpp"

params ["_bomb", ["_actionsType", "BOTH", ["string"]]];

if (!hasInterface) exitWith {};

_possibleActionTypes = ["SCROLL", "ACE", "BOTH"];
if ((_possibleActionTypes findIf { _x isEqualTo _actionsType } == -1)) exitWith {};

_bomb setVariable ["aquerr_bomb_entered_code", "", true];

private _prepareDigitActionFunction = {
    params ["_bomb", "_digit"];

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = [(format ["number_%1", _digit]), _digit, "",
        {
            params ["_target", "_player", "_actionParams"];
            _digit = _actionParams select 0;
            [_player, _target, _digit, true] call FUNC(bomb_enter_digit);

        }, {true}, {}, [_digit]] call ace_interact_menu_fnc_createAction;

        [_bomb, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

    _bomb addAction
    [
        "<t color='#FF0000'>" + _digit + "</t>",	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script

            _digit = _arguments select 0;
            [_caller, _target, _digit, true] call FUNC(bomb_enter_digit);
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
    params ["_bomb", "_actionName"];

    private _clearCodeFunction = {
        params ["_defuser", "_bomb"];
        [_defuser, _bomb] call FUNC(bomb_clear_entered_code);
    };

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = ["code_clear", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_player, _target] call (_actionParams select 0);

        }, {true}, {}, [_clearCodeFunction]] call ace_interact_menu_fnc_createAction;

        [_bomb, 0, ["ACE_MainActions", "aquerr_bomb_keypad"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

    _bomb addAction
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
    params ["_bomb", "_actionName"];

    private _checkTimeFunction = {
        params ["_bomb"];
        _bombTimeSeconds = _bomb getVariable ["aquerr_bomb_time_seconds", 0];
        _bombTimeSecondsStr = str _bombTimeSeconds;
        if (_bombTimeSeconds == 0) then {
            _bombTimeSecondsStr = "???";
        };
        hint format[ LLSTRING(BombTime) + ": %1s", _bombTimeSecondsStr];
    };

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = ["code_clear", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_checkTimeFunction]] call ace_interact_menu_fnc_createAction;

        [_bomb, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

    _bomb addAction
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

private _prepareActionsFunction = {
    params ["_bomb", "_prepareDigitActionFunction", "_prepareClearCodeFunction", "_prepareCheckTimeFunction"];

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _actionParent = ["aquerr_bomb_keypad", LLSTRING(AceMenuBombKeyboard), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_bomb, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;
        _actionParent = ["aquerr_bomb_back", LLSTRING(AceMenuBombBack), "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_bomb, 0, ["ACE_MainActions"], _actionParent] call ace_interact_menu_fnc_addActionToObject;
    };

    _bombActionIds = [];
    _bombActionIds pushBack ([_bomb, LLSTRING(CheckBombTime)] call _prepareCheckTimeFunction);
    _bombActionIds pushBack ([_bomb, LLSTRING(ClearBombCode)] call _prepareClearCodeFunction);
    _bombActionIds pushBack ([_bomb, "0"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "1"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "2"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "3"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "4"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "5"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "6"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "7"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "8"] call _prepareDigitActionFunction);
    _bombActionIds pushBack ([_bomb, "9"] call _prepareDigitActionFunction);

    _bomb setVariable ["aquerr_bomb_action_ids", _bombActionIds, clientOwner];
};

if (GETVAR(_bomb,aquerr_keypad_bomb_interface_initialized,false)) exitWith {};

[_bomb, _prepareDigitActionFunction, _prepareClearCodeFunction, _prepareCheckTimeFunction] call _prepareActionsFunction;