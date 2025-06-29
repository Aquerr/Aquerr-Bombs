#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(zeusIconHandle) = -1;

diag_log format ["Show icons: %1", str EGVAR(main,zeusShowBombIcons)];

if (!EGVAR(main,zeusShowBombIcons) || GVAR(zeusIconHandle) isNotEqualTo -1) exitWith {};
GVAR(zeusIconHandle) = addMissionEventHandler ["Draw3D", {
    call FUNC(zeusDrawBombIcons);
}];