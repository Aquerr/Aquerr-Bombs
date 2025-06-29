#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for simple keypad bomb.

	Parameter(s):
		0: the thing that the script should be attached to
		1: NUMBER - the bomb time (0 = no time, the bomb will explode only on wrong code)
		2: STRING - the solution code
        3: NUMBER - max (wrong) defuse attempts. Default: 1 
		4: BOOLEAN - if the boom should beep every second
		5: STRING - the explosion class name to use
            // "ammo_Missile_Cruise_01" (very big)
            // "helicopterExploBig" (big)
            // "DemoCharge_Remote_Ammo" (medium)
            // "APERSMine_Range_Ammo" (small)
        6: BOOL - if the bomb should NOT be vulnerable to shots and nearby explosions after successful defusal. Default: false
        7: STRING - the bombs's serial number. Not used by the mod.
        8: STRING - the gui type. Available types: CLASSIC, STANDARD
        9: CODE - after defuse function. Executed LOCALLY when bomb is defused. Passed parameters are ["_bomb", "_defuserPlayer"].
        10: BOOL - optional, if the script should be run globally. Can be skipped in most cases.

	Example:
		[_myBombThing, 60, "2454"] call abombs_main_fnc_init_keypad_bomb_full;
		[_myBombThing, 0, "123", true, "GrenadeHand"] call abombs_main_fnc_init_keypad_bomb_full;
        [_myBombThing, 0, "123", true, "DemoCharge_Remote_Ammo"] call abombs_main_fnc_init_keypad_bomb_full;
*/

params [
    "_device", 
    ["_timeSeconds", 60, [0]], 
    ["_solutionCode", "0000", ["string"]], 
    ["_maxDefuseAttempts", 1, [0]], 
    ["_shouldBeep", true, [true]], 
    ["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]],
    ["_removeShotVulnerabilityAfterDefuse", false, [true]],
    ["_serialNumber", "", ["string"]], 
    ["_guiType", "STANDARD", ["string"]], 
    ["_afterDefuseFunction", {}, [{}]], 
    ["_global", true, [true]]
];

if ((isNil "_device") || {isNull(_device)}) exitWith { hint LELSTRING(common,MustSelectObject) };

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_device getVariable QGVAR(init_keypad_bomb_full_JIP)}}}}) exitWith {

    private _id = [QGVAR(init_keypad_bomb_full), [_device, _timeSeconds, _solutionCode, _maxDefuseAttempts, _shouldBeep, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber, _guiType, _afterDefuseFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _device] call CBA_fnc_removeGlobalEventJIP;

    _device setVariable [QGVAR(init_keypad_bomb_full_JIP), _id, true];
};

private _clientCleanupFunction = {
    params ["_device"];

    _actionIds = _device getVariable ["aquerr_bomb_action_ids", []];
    {
        _device removeAction _x;
    } forEach _actionIds;
};

 private _prepareServerVariablesFunction = {
     params ["_device", "_explosionClassName", "_afterDefuseFunction", "_maxDefuseAttempts"];

     _device setVariable ["abombs_bomb_type", "KEYPAD", true];
     _device setVariable ["abombs_bomb_is_armed", true, true];
     _device setVariable ["abombs_bomb_after_defuse_function", _afterDefuseFunction, true];
     _device setVariable ["abombs_bomb_max_defuse_attempts", _maxDefuseAttempts, true];
 };

 private _prepareClientVariablesFunction = {
    params ["_device", "_clientCleanupFunction", "_removeShotVulnerabilityAfterDefuse"];

    _device setVariable ["abombs_bomb_remove_shot_vulnerability_after_defuse", _removeShotVulnerabilityAfterDefuse];
    _device setVariable ["abombs_bomb_client_cleanup_function", _clientCleanupFunction];
 };

if (isServer) then {
    if (_device getVariable ["abombs_bomb_is_armed", false]) exitWith {hint LLSTRING(BombAlreadyArmed);};

    [_device, _explosionClassName, _afterDefuseFunction, _maxDefuseAttempts] call _prepareServerVariablesFunction;

    _failureFunction = {
        params ["_bomb", "_defuser"];
        [_bomb] call _clientCleanUpFunction;
        [_bomb, _defuser] call FUNC(bomb_explode);
        if (dialog) then {
            closeDialog 0;
        };
    };

    _device setVariable ["abombs_keypad_failure_function", _failureFunction, true];

    [_device, _solutionCode] call FUNC(init_keypad_solution_code);
    [_device, _timeSeconds] call FUNC(init_bomb_timer);
};

if (hasInterface) then {
    if (GETVAR(_device,aquerr_keypad_bomb_interface_initialized,false)) exitWith {};

    // For JIP players when bomb is already defused
    if (GETVAR(_device,abombs_bomb_was_defused,false)) exitWith {};

    [_device, _clientCleanupFunction, _removeShotVulnerabilityAfterDefuse] call _prepareClientVariablesFunction;
    [_device, true, _explosionClassName, 2] call FUNC(register_explosive_handlers_for_object);
    [_device, _guiType] call FUNC(init_keypad_gui);
    [_device, "BOTH"] call FUNC(init_keypad_actions);
};

[_device, _serialNumber] call FUNC(init_serial_number);

if (hasInterface) then {
    SETVAR(_device,aquerr_keypad_bomb_interface_initialized,true);
};