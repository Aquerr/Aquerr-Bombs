#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(isAceInteractionMenuLoaded) = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");

#include "cba_settings.inc.sqf"

ADDON = true;