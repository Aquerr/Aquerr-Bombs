/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used for letting the local client know about the bomb (currently used only for zeus icons). 
        Should not be used outside the mod.

	Example:
		["_bomb"] call abombs_main_fnc_addRegisteredBomb;
*/
params ["_bomb"];

if (!hasInterface) exitWith {};

_registeredBombs = localNamespace getVariable ["abombs_registered_bombs", []];

// Bomb is already registered
if (_registeredBombs findIf { _x == _bomb } > -1) exitWith {};

_registeredBombs pushBack _bomb;
localNamespace setVariable ["abombs_registered_bombs", _registeredBombs];
