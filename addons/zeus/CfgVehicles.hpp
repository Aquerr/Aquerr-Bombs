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
    class GVAR(moduleExplode): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Explode_DisplayName);
        curatorInfoType = QGVAR(RscExplode);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleRemoveVulnerableObject): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Remove_Shot_Vulnerable_DisplayName);
        function = QFUNC(ui_removeShotVulnerable);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleVulnerableObject): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Shot_Vulnerable_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerable);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleVulnerableObjectsGlobal): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerableGlobal);    
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleKeypadBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Keypad_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscKeypadBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };

    class GVAR(moduleWireBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Wire_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscWireBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };

    class GVAR(moduleMemoryBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Memory_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscMemoryBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };

    class GVAR(moduleMorseBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = ECSTRING(main,Module_Morse_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscMorseBomb);
        icon = "a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa";
    };
};
