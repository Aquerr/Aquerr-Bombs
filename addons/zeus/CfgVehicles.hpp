class CfgVehicles {
    class Module_F;

    class GVAR(baseModule): Module_F {
        author = "Aquerr";
        category = QGVAR(ABOMBS);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
    };

    class GVAR(moduleVulnerableObject): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerable);
        icon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
    };

    class GVAR(moduleVulnerableObjectsGlobal): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerableGlobal);
        icon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
    };

    class GVAR(moduleScrollKeypadBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Scroll_Keypad_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscScollKeypadBomb);
        icon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
    };

    class GVAR(moduleScrollWireBomb): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Scroll_Wire_Bomb_DisplayName);
        curatorInfoType = QGVAR(RscScollWireBomb);
        icon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
    };
};