#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleScrollKeypadBomb),
            QGVAR(moduleScrollWireBomb),
            QGVAR(moduleVulnerableObject)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
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