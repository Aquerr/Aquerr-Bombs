#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used to check if player can defuse the bomb.
        This function check if bomb is active, if the player needs to be EOD/Explosive Specialist
        and if the player need to have certain items in its inventory to perform defusal.

	Parameter(s):
        0: OBJECT - the bomb object
        1: PLAYER - the player that is willing to defuse the bomb.

	Example:
        [_object, _myPlayer] call abombs_main_fnc_can_defuse_bomb;
*/

params ["_bomb", "_user"];

// Check if the bomb is armed. If it is not then... well... no need to defuse it again. :D
if ((_bomb getVariable ["abombs_bomb_is_armed", false]) == false) exitWith {
    false
};

// Check if the player has required EOD trait
_requireEOD = _bomb getVariable ["abombs_require_eod", false];
if (_requireEOD && {(_user getVariable ["ACE_isEOD", _user getUnitTrait "explosiveSpecialist"]) in [0, false]}) exitWith {
    false
};

// Check if the player has required defusal items
_requiredDefusalItems = _bomb getVariable ["abombs_required_defusal_items", []];
_hasRequiredItems = true;
if ((count _requiredDefusalItems) > 0) then {
    {
        private _item = _x;
        if (([_user, _item] call BIS_fnc_hasItem) == false) exitWith {
            _hasRequiredItems = false;
            false
        };
    } forEach _requiredDefusalItems;
};

_hasRequiredItems
