/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Sets the keypad solution code. Server only.

	Parameter(s):
        0: OBJECT - the object that the keypad is attached to
        1: STRING - the solution code

	Example:
        [_myObject, "12345"] call abombs_main_fnc_init_keypad_solution_code;
*/

params ["_object", ["_solutionCode", "0000", ["string"]]];

if (!isServer) exitWith {};

_object setVariable ["abombs_keypad_solution_code", _solutionCode, true];