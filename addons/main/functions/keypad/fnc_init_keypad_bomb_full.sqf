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
    "_bomb", 
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

if ((isNil "_bomb") || {isNull(_bomb)}) exitWith { hint LELSTRING(common,MustSelectObject) };

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_bomb getVariable QGVAR(init_keypad_bomb_full_JIP)}}}}) exitWith {

    private _id = [QGVAR(init_keypad_bomb_full), [_bomb, _timeSeconds, _solutionCode, _maxDefuseAttempts, _shouldBeep, _explosionClassName, _removeShotVulnerabilityAfterDefuse, _serialNumber, _guiType, _afterDefuseFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _bomb] call CBA_fnc_removeGlobalEventJIP;

    _bomb setVariable [QGVAR(init_keypad_bomb_full_JIP), _id, true];
};

private _clientCleanupFunction = {
    params ["_bomb"];

    _actionIds = _bomb getVariable ["aquerr_bomb_action_ids", []];
    {
        _bomb removeAction _x;
    } forEach _actionIds;
};

 private _prepareServerVariablesFunction = {
     params ["_bomb", "_explosionClassName", "_afterDefuseFunction", "_maxDefuseAttempts"];

     _bomb setVariable ["abombs_bomb_type", "KEYPAD", true];
     _bomb setVariable ["abombs_bomb_is_armed", true, true];
     _bomb setVariable ["abombs_bomb_after_defuse_function", _afterDefuseFunction, true];
     _bomb setVariable ["abombs_bomb_max_defuse_attempts", _maxDefuseAttempts, true];
 };

 private _prepareClientVariablesFunction = {
    params ["_bomb", "_clientCleanupFunction", "_removeShotVulnerabilityAfterDefuse"];

    _bomb setVariable ["abombs_bomb_remove_shot_vulnerability_after_defuse", _removeShotVulnerabilityAfterDefuse];
    _bomb setVariable ["abombs_bomb_client_cleanup_function", _clientCleanupFunction];
 };

if (isServer) then {
    if (_bomb getVariable ["abombs_bomb_is_armed", false]) exitWith {hint LLSTRING(BombAlreadyArmed);};

    [_bomb, _explosionClassName, _afterDefuseFunction, _maxDefuseAttempts] call _prepareServerVariablesFunction;

    _failureFunction = {
        params ["_bomb", "_defuser"];
        [_bomb] call _clientCleanUpFunction;
        [_bomb, _defuser] call FUNC(bomb_explode);
        if (dialog) then {
            closeDialog 0;
        };
    };

    _bomb setVariable ["abombs_keypad_failure_function", _failureFunction, true];

    [_bomb, _solutionCode] call FUNC(init_keypad_solution_code);
    [_bomb, _timeSeconds] call FUNC(init_bomb_timer);
};

if (hasInterface) then {
    if (GETVAR(_bomb,aquerr_keypad_bomb_interface_initialized,false)) exitWith {};

    [_bomb, _clientCleanupFunction, _removeShotVulnerabilityAfterDefuse] call _prepareClientVariablesFunction;
    [_bomb, _guiType] call FUNC(init_keypad_gui);
    [_bomb, "BOTH"] call FUNC(init_keypad_actions);

    // For JIP players when bomb is already defused
    _wasDefused = GETVAR(_bomb,abombs_bomb_was_defused,false);
    if (!_wasDefused || (_wasDefused && !_removeShotVulnerabilityAfterDefuse)) then {
        [_bomb, true, _explosionClassName, 2] call FUNC(register_explosive_handlers_for_object);
    };
};

[_bomb, _serialNumber] call FUNC(init_serial_number);

if (hasInterface) then {
    SETVAR(_bomb,aquerr_keypad_bomb_interface_initialized,true);
};
