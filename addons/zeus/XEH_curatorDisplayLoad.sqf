#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(zeusIconHandle) = -1;
if (!GVARMAIN(zeusShowBombIcons) || GVAR(zeusIconHandle) isNotEqualTo -1) exitWith {};
GVAR(zeusIconHandle) = addMissionEventHandler ["Draw3D", {
    systemChat "start drawing!";
    call FUNC(zeusDrawBombIcons);
}];