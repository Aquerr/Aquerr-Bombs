#include "..\script_component.hpp"

params ["_bomb", ["_guiType", "STANDARD", ["string"]]];

if (!hasInterface) exitWith {};

_possibleKeypadGuiTypes = ["CLASSIC", "STANDARD"];
if ((_possibleKeypadGuiTypes findIf { _x isEqualTo _guiType } == -1)) exitWith {};

private _prepareOpenGuiFunction = {
    params ["_bomb", "_actionName"];

    private _openGui = {
        params ["_bomb"];

        _guiType = _bomb getVariable ["aquerr_keypad_bomb_gui_type", "STANDARD"];
        if (_guiType isEqualTo "STANDARD") exitWith {
            [_bomb] call FUNC(open_keypad_bomb_interface);
        };

        if (_guiType isEqualTo "CLASSIC") exitWith {
            [_bomb] call FUNC(open_classic_bomb_interface);
        };
    };

    if (GVAR(isAceInteractionMenuLoaded)) then {
        _action = ["open_gui", _actionName, "",
        {
            params ["_target", "_player", "_actionParams"];
            [_target] call (_actionParams select 0);

        }, {true}, {}, [_openGui]] call ace_interact_menu_fnc_createAction;

        [_bomb, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };

    _bomb addAction
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

 _bomb setVariable ["aquerr_keypad_bomb_gui_type", _guiType];

_bombActionIds = _bomb getVariable ["aquerr_bomb_action_ids", []];
_bombActionIds pushBack ([_bomb, LLSTRING(OpenBombInterface)] call _prepareOpenGuiFunction);
_bomb setVariable ["aquerr_bomb_action_ids", _bombActionIds, clientOwner];