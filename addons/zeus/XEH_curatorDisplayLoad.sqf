#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(zeusIconHandle) = -1;

if (!EGVAR(main,zeusShowBombIcons) || GVAR(zeusIconHandle) isNotEqualTo -1) exitWith {};
GVAR(zeusIconHandle) = addMissionEventHandler ["Draw3D", {
    call FUNC(zeusDrawBombIcons);
}];
