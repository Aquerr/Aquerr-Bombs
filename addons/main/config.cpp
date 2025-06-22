#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "";
        authors[] = {"Aquerr"};
        authorUrl = "https://github.com/Aquerr";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
#include "CfgUnitInsignia.hpp"
#include "ui\Constants.hpp"
#include "ui\Classic_Keypad_Bomb_Interface.hpp"
#include "ui\Keypad_Bomb_Interface.hpp"
#include "ui\Math_Bomb_Interface.hpp"
#include "ui\Memory_Keypad_Bomb_Interface.hpp"
#include "ui\Morse_Bomb_Interface.hpp"