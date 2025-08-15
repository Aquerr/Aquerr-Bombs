#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleKeypadBomb),
            QGVAR(moduleWireBomb),
            QGVAR(moduleMemoryBomb),
            QGVAR(moduleMorseBomb),
            QGVAR(moduleVulnerableObject),
            QGVAR(moduleVulnerableObjectsGlobal),
            QGVAR(moduleRemoveVulnerableObject),
            QGVAR(moduleExplode)
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
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "ui\RscAttributes.hpp"
