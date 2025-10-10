#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(edenModuleExplode),
            QGVAR(edenModuleVulnerableObjects),
            QGVAR(edenModuleWireBomb),
            QGVAR(edenModuleKeypadBomb),
            QGVAR(edenModuleMemoryBomb),
            QGVAR(edenModuleMorseBomb)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "abombs_main"};
        author = "";
        authors[] = {"Aquerr"};
        authorUrl = "https://github.com/Aquerr";
        VERSION_CONFIG;
    };
};

#include "CfgFactionClasses.hpp"
#include "Cfg3DEN.hpp"
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
