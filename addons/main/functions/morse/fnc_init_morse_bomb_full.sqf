#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for morse code bomb.
        Requires knowledge about International Morse Code (with 26 letters and 10 numerals). Ref: https://en.wikipedia.org/wiki/Morse_code
        A player need to decode the message and enter the solution message that either is the same as decoded message or can be found with help of decoded message (Mission Maker decides).

	Parameter(s):
		0: the thing that the script should be attached to
		1: NUMBER - the bomb time (0 = no time, the bomb will explode only on wrong code)
        2: BOOLEAN - if the boom should beep every second
        3: STRING - the encoded message (only 26 letters and 10 numerals from https://en.wikipedia.org/wiki/Morse_code are supported)
        4: STRING - the solution message
        5: STRING - the explosion class name to use
            // "ammo_Missile_Cruise_01" (very big)
            // "helicopterExploBig" (big)
            // "DemoCharge_Remote_Ammo" (medium)
            // "APERSMine_Range_Ammo" (small)
        6: STRING - the bombs's serial number. Not used by the mod.
        7: CODE - after defuse function. Executed LOCALLY when bomb is defused. Passed parameters are ["_bomb", "_defuserPlayer"].
        8: BOOL - optional, if the script should be run globally. Can be skipped in most cases.

	Example:
		[_myBombThing, 100] call abombs_main_fnc_init_morse_bomb_full;
		[_myBombThing, 0, true, "GrenadeHand"] call abombs_main_fnc_init_morse_bomb_full;
*/

params ["_bomb", 
["_timeSeconds", 60, [0]], 
["_shouldBeep", true, [true]], 
["_encodedMessage", "", ["string"]], 
["_solutionMessage", "", ["string"]],
["_explosionClassName", "DemoCharge_Remote_Ammo", ["string"]], 
["_serialNumber", "", ["string"]], 
["_afterDefuseFunction", {}, [{}]], 
["_global", true, [true]]];

if ((isNil "_bomb") || {isNull(_bomb)}) exitWith { hint LELSTRING(common,MustSelectObject) };

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_bomb getVariable QGVAR(init_morse_bomb_full_JIP)}}) exitWith {

    private _id = [QGVAR(init_morse_bomb_full), [_bomb, _timeSeconds, _shouldBeep, _encodedMessage, _solutionMessage, _explosionClassName, _serialNumber, _afterDefuseFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _bomb] call CBA_fnc_removeGlobalEventJIP;

    _bomb setVariable [QGVAR(init_morse_bomb_full_JIP), _id, true];
};

private _prepareServerVariablesFunction = {
     params ["_bomb", "_encodedMessage", "_solutionMessage", "_afterDefuseFunction"];

     _bomb setVariable ["aquerr_bomb_type", "MORSE", true];
     _bomb setVariable ["aquerr_bomb_is_armed", true, true];
     _bomb setVariable ["aquerr_bomb_after_defuse_function", _afterDefuseFunction, true];
     _bomb setVariable ["aquerr_morse_bomb_encoded_message", _encodedMessage, true];
     _bomb setVariable ["aquerr_morse_bomb_solution_message", _solutionMessage, true];
 };

 if (isServer) then {
    if (_bomb getVariable ["aquerr_bomb_is_armed", false]) exitWith {hint LLSTRING(BombAlreadyArmed);};

    [_bomb, _encodedMessage, _solutionMessage, _afterDefuseFunction] call _prepareServerVariablesFunction;
    [_bomb, _timeSeconds] call FUNC(init_bomb_timer);
};

if(hasInterface) then {
    if (GETVAR(_bomb,aquerr_morse_bomb_interface_initialized,false)) exitWith {};

    [_bomb, true, _explosionClassName, 2] call FUNC(register_explosive_handlers_for_object);
    [_bomb] call FUNC(init_morse_bomb_gui_action);
};

[_bomb, _serialNumber] call FUNC(init_serial_number);

if (hasInterface) then {
    SETVAR(_bomb,aquerr_morse_bomb_interface_initialized,true);
};