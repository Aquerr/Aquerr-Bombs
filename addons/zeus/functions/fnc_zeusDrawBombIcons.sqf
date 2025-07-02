#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Draws bomb icons in zeus interface. Should not be used outside the mod.

	Example:
		[] call abombs_zeus_fnc_zeusDrawBombIcons;
*/

private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
private _range = 150;
private _icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";

_registeredBombs = (localNamespace getVariable ["abombs_registered_bombs", []]);

{
    _pos = getPosASL _x;
    _size = linearConversion [_range, 50, _pos distance _camPos, 0, 1, true];
    drawIcon3D [_icon, [1, 1, 1, 1], ASLToAGL _pos, _size, _size, 0, "", true];
} forEach (_registeredBombs inAreaArray [_camPos, _range, _range, 0, false, -1]);
