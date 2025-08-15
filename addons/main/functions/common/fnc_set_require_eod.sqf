#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used to set requirement for EOD during bomb defusal. 
        EOD = ACE EOD or Vanilla explosiveSpecialist.

	Parameter(s):
        0: OBJECT - the bomb object
        1: BOOL - if the EOD trait is required.

	Example:
        [_object, true] call abombs_main_fnc_set_require_eod;
*/

params ["_object", ["_requireEOD", false, [true]]];

_object setVariable ["abombs_require_eod", _requireEOD, true];
