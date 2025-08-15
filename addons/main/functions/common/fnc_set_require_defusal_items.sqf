#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used to set required items a player needs to have to defuse the bomb. 

	Parameter(s):
        0: OBJECT - the bomb object
        1: ARRAY - of items class names.

	Example:
        [_object, ["ACE_defusalKit", "Toolkit"]] call abombs_main_fnc_set_require_defusal_items;
*/

params ["_object", ["_requiredItems", [], [["Toolkit"]]]];

_object setVariable ["abombs_required_defusal_items", _requiredItems, true];
