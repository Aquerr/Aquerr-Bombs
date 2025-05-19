#include "..\script_component.hpp"

params ["_bomb", ["_serialNumber", "", ["string"]]];

if (isServer) then {
    _bomb setVariable ["aquerr_bomb_serial_number", _serialNumber, true];
};

if (hasInterface) then {
    private _prepareCheckSerialNumberFunction = {
        params ["_bomb", "_actionName"];

        private _checkSerialNumber = {
            params ["_bomb"];
            _bombSerialNumber = _bomb getVariable ["aquerr_bomb_serial_number", ""];
            hint format[ LLSTRING(BombSerialNumber) + ": %1", _bombSerialNumber];
        };

        if (GVAR(isAceInteractionMenuLoaded)) then {
            _action = ["check_serial_number", _actionName, "",
            {
                params ["_target", "_player", "_actionParams"];
                [_target] call (_actionParams select 0);

            }, {true}, {}, [_checkSerialNumber]] call ace_interact_menu_fnc_createAction;

            [_bomb, 0, ["ACE_MainActions", "aquerr_bomb_back"], _action] call ace_interact_menu_fnc_addActionToObject;
        };

        _bomb addAction
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

    _bombActionIds = _bomb getVariable ["aquerr_bomb_action_ids", []];
    _bombActionIds pushBack ([_bomb, LLSTRING(CheckBombSerialNumber)] call _prepareCheckSerialNumberFunction);
    _bomb setVariable ["aquerr_bomb_action_ids", _bombActionIds, clientOwner];
};