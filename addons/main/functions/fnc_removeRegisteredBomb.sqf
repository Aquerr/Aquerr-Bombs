/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Used for letting the local client know about the bomb (currently used only for zeus icons). 
        Should not be used outside the mod.

	Example:
		["_bomb"] call abombs_main_fnc_removeRegisteredBomb;
*/
params ["_bomb"];

if (!hasInterface) exitWith {};

_registeredBombs = localNamespace getVariable ["abombs_registered_bombs", []];

_bombIndex = _registeredBombs findIf { _x == _bomb };

// Bomb is not registered
if (_bombIndex == -1) exitWith {};

_registeredBombs deleteAt _bombIndex;
localNamespace setVariable ["abombs_registered_bombs", _registeredBombs];
