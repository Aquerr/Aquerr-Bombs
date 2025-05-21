#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for simple bomb with scroll/ace action that shows colored wires in hint message.
		To defuse the bomb, one must correctly guess the color that occurrs the most times.

	Parameter(s):
		1: OBJECT - the thing that the script should be attached to
		2: NUMBER - optional, the bomb time (0 = no time, the bomb will explode only on wrong cable cut)
		3: BOOLEAN - if the bomb should beep every second
		4: STRING - optional, the wire sign (default "|"). Pass nil if you want to use the default sign.
		5: NUMBER - optional, the wires count (default 40). Can't be less than 4. Pass nil if you want to use the default count.
		6: STRING - optional, the explosion class name to use
		            // "ammo_Missile_Cruise_01" (very big)
                    // "helicopterExploBig" (big)
                    // "DemoCharge_Remote_Ammo" (medium)
                    // "APERSMine_Range_Ammo" (small)
        7: CODE - optional, after defuse function. Executed LOCALLY when bomb is defused. Passed parameters are ["_bomb", "_defuserPlayer"]
        8: BOOL - optional, if the script should be run globally. Can be skipped in most cases.

	Example:
		[myBombThing, 360, true, "#", 20] call abombs_main_fnc_init_wire_bomb_full;
		[myBombThing, 0, false, nil, nil, "GrenadeHand"] call abombs_main_fnc_init_wire_bomb_full;
*/

params ["_device", ["_timeSeconds", 60, [0]], ["_shouldBeep", true, [true]], ["_wireSign", "|", ["string"]], ["_wireCount", 40, [40]], ["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]], ["_afterDefuseFunction", {}, [{}]], ["_global", true, [true]]];

if ((isNil "_device") || {isNull(_device)}) exitWith { hint LELSTRING(common,MustSelectObject) };
if ((_wireCount < 4)) exitWith { hint LLSTRING(WireCountCantBeLessThanFour)};

if (_global && {isMultiplayer} && {isNil {_device getVariable QGVAR(init_wire_bomb_full_JIP)}}) exitWith {

    private _id = [QGVAR(init_wire_bomb_full), [_device, _timeSeconds, _shouldBeep, _wireSign, _wireCount, _explosionClassName, _afterDefuseFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _device] call CBA_fnc_removeGlobalEventJIP;

    _device setVariable [QGVAR(init_wire_bomb_full_JIP), _id, true];
};

private _generateBombWires = {
    params ["_device", "_wireCount"];

    private _remaining = _wireCount - 3; // At least one for each wire color.

    private _correctWires = 0;
    private _wires2 = 0;
    private _wires3 = 0;

    while {true} do {
        private _part1 = floor random (_remaining + 1);
        private _part2 = floor random (_remaining - _part1 + 1);
        private _part3 = _remaining - _part1 - _part2;

        _correctWires = _part1 + 1;
        _wires2 = _part2 + 1;
        _wires3 = _part3 + 1;

        if (_correctWires > _wires2 && _correctWires > _wires3) exitWith {};
    };

    // Generate wires
    // 1 = Red
    // 2 = Green
    // 3 = Blue
    private _possibleWireColors = [1, 2, 3];
    private _solutionWireColor = (floor random (count _possibleWireColors)) + 1;
    private _wrongWireColors = _possibleWireColors select {_x != _solutionWireColor};

    //TODO: Make the old randomization way "HARD MODE"
    // private _remaining = _wireCount mod (count _possibleWireColors);
    // private _correctWiresCount = floor (_wireCount / (count _possibleWireColors)) + _remaining;
    // private _wrongWiresCount = floor (_wireCount / (count _possibleWireColors)) * (count _possibleWireColors - 1);

    // if (_remaining == 0) then {
    //     // Change two wrong cables to correct ones
    //     _wrongWiresCount = _wrongWiresCount - 2;
    //     _correctWiresCount = _correctWiresCount + 2;
    // };

    private _wires = []; // Contains wires in following format [wire_color, wire_color];
    
    //TODO: Make the old randomization way "HARD MODE"
    // Add wrong wrires
    // {
    //     _wrongWireColor = _x;
    //     for "_i" from 1 to (_wrongWiresCount / 2) do {
    //         _wires pushBack _wrongWireColor;
    //     };
    // } forEach _wrongWireColors;

    // Add correct wires
    for "_i" from 1 to _correctWires do {
        _wires pushBack _solutionWireColor;
    };

    _wrongWireColor1 = _wrongWireColors select 0;
    for "_i" from 1 to (_wires2) do {
        _wires pushBack _wrongWireColor1;
    };

    _wrongWireColor2 = _wrongWireColors select 1;
    for "_i" from 1 to (_wires3) do {
        _wires pushBack _wrongWireColor2;
    };

    _device setVariable ["aquerr_bomb_wires", _wires call BIS_fnc_arrayShuffle, true];
    _device setVariable ["aquerr_bomb_solution_wire", _solutionWireColor, true];
};

 private _cutColoredWireFunction = {
    params ["_defuser", "_device", "_wireColor"];

    private _isArmed = _device getVariable ["aquerr_bomb_is_armed", false];
    if (!_isArmed) exitWith {hint LLSTRING(BombAlreadyDefused)};

    _solutionWireColor = _device getVariable ["aquerr_bomb_solution_wire", ""];

    if (_solutionWireColor == parseNumber _wireColor) then {
            _device setVariable ["aquerr_bomb_is_armed", false, true];
            hint LLSTRING(BombDefused);
            [_device, QGVAR(BombDefuse)] remoteExec ["say3D"];

            [QGVAR(BombDefused), [_device, _defuser]] call CBA_fnc_globalEvent;

            _afterDefuseFunction = _device getVariable ["aquerr_bomb_after_defuse_function", {}];
            [_device, _defuser] call _afterDefuseFunction;
        } else {
            [player, _device] call FUNC(bomb_explode);
        };
 };

 private _prepareWireCutAction = {
    /*
        _wireColor:
            1 = RED
            2 = GREEN
            3 = BLUE
    */
    params ["_device", "_actionName", "_wireColor", "_cutColoredWireFunction"];

    _textColor = "#FF0000";
    if ((parseNumber _wireColor) == 2) then {
        _textColor = "#00FF00";
    };

    if ((parseNumber _wireColor) == 3) then {
        _textColor = "#0000FF";
    };

    private _formattedActionName = format ["<t color='%1'>%2</t>", _textColor, _actionName];

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = [(format ["wire_color_%1", _wireColor]), _formattedActionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            _wireColor = _actionParams select 0;
            _cutColoredWireFunction = _actionParams select 1;
            [_player, _target, _wireColor] call _cutColoredWireFunction;

        }, {true}, {}, [_wireColor, _cutColoredWireFunction]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
        [["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;
    };

    _device addAction
    [
        _formattedActionName,	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script

            _wireColor = _arguments select 0;
            _cutColoredWireFunction = _arguments select 1;
            [_caller, _target, _wireColor] call _cutColoredWireFunction;
        },
        [_wireColor, _cutColoredWireFunction],		// arguments
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

 private _showWiresInHintFunction = {
    params ["_device", "_wireSign"];

    _wires = _device getVariable ["aquerr_bomb_wires", []];

    if (count _wires == 0) exitWith {"Bomb has no wires";};

    private _wireTextColorResolver = {
        params ["_wireColorNumber"];

        // Default RED
        _textColor = "#FF0000";
        if (_wireColorNumber == 2) then {
            _textColor = "#00FF00";
        };

        if (_wireColorNumber == 3) then {
            _textColor = "#0000FF";
        };
        _textColor;
    };

    private _wiresInRow = 0;
    private _message = "";
    private _messageHeader = LLSTRING(CutMostOccurringWire);
    _message = _message + _messageHeader + "<br/>";
    {
        _wireColor = _x;

        // A row consist of 5 wires
        if (_wiresInRow == 8) then {
            _message = _message + "<br/>";
            _wiresInRow = 0;
        };

        _wireTextColor = (_wireColor call _wireTextColorResolver);
        _wireText = format ["<t size='2' color='%1'> %2 </t>", _wireTextColor, _wireSign];

        _message = _message + _wireText;
        _wiresInRow = _wiresInRow + 1;

    } forEach _wires;

    _solutionCode = _device getVariable ["aquerr_bomb_solution_wire", 0];
    hint parseText _message;
 };

 private _prepareShowBombWiresInHintAction = {
    params ["_device", "_actionName", "_wireSign", "_showWiresInHintFunction"];

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = ["show_wires", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            _showWiresInHintFunction = _actionParams select 0;
            _wireSign = _actionParams select 1;
            [_target, _wireSign] call _showWiresInHintFunction;

        }, {true}, {}, [_showWiresInHintFunction, _wireSign]] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
        [["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;
    };
    
    _device addAction
    [
        _actionName,	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script

            _showWiresInHintFunction = _arguments select 0;
            _wireSign = _arguments select 1;
            [_target, _wireSign] call _showWiresInHintFunction;
        },
        [_showWiresInHintFunction, _wireSign],		// arguments
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
         hint format[LLSTRING(BombTime) + ": %1s", _bombTimeSecondsStr];
     };

    if (GVAR(isAceInteractionMenuLoaded)) then {
         _action = ["code_clear", _actionName, "",
         {
             params ["_target", "_player", "_actionParams"];
             [_target] call (_actionParams select 0);

         }, {true}, {}, [_checkTimeFunction]] call ace_interact_menu_fnc_createAction;

         [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

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


 // Actions
 private _prepareActionsFunction = {
        params ["_device", "_cutColoredWireFunction", "_prepareWireCutAction", "_prepareShowBombWiresInHintAction", "_showWiresInHintFunction", "_wireSign", "_prepareCheckTimeFunction"];

        [_device, LLSTRING(CheckBombTime)] call _prepareCheckTimeFunction;
        [_device, LLSTRING(CheckBombWires), _wireSign, _showWiresInHintFunction] call _prepareShowBombWiresInHintAction;
        [_device, LLSTRING(CutRedWire), "1", _cutColoredWireFunction] call _prepareWireCutAction;
        [_device, LLSTRING(CutGreenWire), "2", _cutColoredWireFunction] call _prepareWireCutAction;
        [_device, LLSTRING(CutBlueWire), "3", _cutColoredWireFunction] call _prepareWireCutAction;
 };


 //Variables
 private _prepareServerVariablesFunction = {
     params ["_device", "_explosionClassName", "_shouldBeep", "_afterDefuseFunction"];

     _device setVariable ["aquerr_bomb_beep_enabled", _shouldBeep, true];
     _device setVariable ["aquerr_bomb_is_armed", true, true];
     _device setVariable ["aquerr_bomb_explosion_class_name", _explosionClassName, true];
     _device setVariable ["aquerr_bomb_after_defuse_function", _afterDefuseFunction, true];
 };

 private _prepareClientVariablesFunction = {
    params ["_device"];

    SETVAR(_device,aquerr_wire_bomb_interface_initialized,true);
 };

// Execution code
if (isServer) then {

    if (_device getVariable ["aquerr_bomb_is_armed", false]) exitWith {hint LLSTRING(BombAlreadyArmed);};

    [_device, _explosionClassName, _shouldBeep, _afterDefuseFunction] call _prepareServerVariablesFunction;
    [_device, _timeSeconds] call FUNC(init_bomb_timer);
    [_device, _wireCount] call _generateBombWires;
};

if (hasInterface) then {

    if (GETVAR(_device,aquerr_wire_bomb_interface_initialized,false)) exitWith {};

    [_device] call _prepareClientVariablesFunction;
    [_device, _cutColoredWireFunction, _prepareWireCutAction, _prepareShowBombWiresInHintAction, _showWiresInHintFunction, _wireSign, _prepareCheckTimeFunction] call _prepareActionsFunction;
    [_device, true, _explosionClassName, 2] call FUNC(register_explosive_handlers_for_object);
};