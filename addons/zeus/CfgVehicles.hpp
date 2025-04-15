class CfgVehicles {
    class Logic;
    class Module_F: Logic {};

    // Base module
    class GVAR(baseModule): Module_F {
        author = "Aquerr";
        category = QGVAR(ABOMBS);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 2; // 0 hidden from Zeus
    };

    ///////////////////////////////////////////////////////////
    // Zeus modules

    class GVAR(moduleVulnerableObject): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerable);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleVulnerableObjectsGlobal): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerableGlobal);    
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleScrollKeypadBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Scroll_Keypad_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscScollKeypadBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };

    class GVAR(moduleScrollWireBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Scroll_Wire_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscScollWireBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };
};