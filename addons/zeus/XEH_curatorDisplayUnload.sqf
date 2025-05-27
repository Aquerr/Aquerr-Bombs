#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (GVAR(zeusIconHandle) >= 0) then {
    removeMissionEventHandler ["Draw3D", GVAR(zeusIconHandle)];
    GVAR(zeusIconHandle) = -1;
};