#include "script_component.hpp"

private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
private _pos = nil;
private _size = nil;
private _icon = nil;
private _range = 150;
private _icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";

systemChat str GVARMAIN(registeredBombs);

{
    _pos = getPosASL _x;
    _size = linearConversion [_range, 50, _pos distance _camPos, 0, 1, true];
    drawIcon3D [_icon, [1, 1, 1, 1], ASLToAGL _pos, _size, _size, 0, "", true];
} forEach (GVARMAIN(registeredBombs) inAreaArray [_camPos, _range, _range, 0, false, -1]);