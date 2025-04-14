class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Combo;
            class Edit;
            class EditArray;
            class Checkbox;
            class EditMulti3;
            class EditCodeMulti3;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

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
        // icon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleVulnerableObjectsGlobal): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        curatorInfoType = QGVAR(RscShotVulnerableGlobal);    
        icon = "DBUG\pictures\options.paa";
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

    ///////////////////////////////////////////////////////////////////////////////////
    //EDEN Modules (Move to EDEN package)

    class GVAR(edenModuleVulnerableObjects): GVAR(baseModule) {
        displayName = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        icon = "DBUG\pictures\options.paa";
        function = QFUNC(edenModuleShotVulnerable);
        scope = 2;
        scopeCurator = 0;
        class Attributes: AttributesBase {
            class ClassNames: Edit {
                property = QGVAR(edenModuleVulnerableObjects_ClassNames);
                displayName = CSTRING(ClassNamesLabel);
                tooltip = CSTRING(ClassNamesLabelTooltip);
                typeName = "STRING";
                defaultValue = "['Land_MetalBarrel_F','Land_GasTank_02_F','Barrel1']";
            };
            class DeleteAfterExplosion: Checkbox {
                property = QGVAR(edenModuleShotVulnerable_DeleteAfterExplosion);
                displayName = CSTRING(DeleteWreckAfterExplosionLabel);
                tooltip = "";
                typeName = "BOOL";
                defaultValue = "true";
            };
            class ExplosionClassName: Default {
                control = QGVAR(explosionClassName);
                property = QGVAR(edenModulePropertyCommon_explosionClassName);
                typeName = "STRING";
                defaultValue = "'DemoCharge_Remote_Ammo'";
            };
            class ExplosionClassNameOverride: Default {
                control = QGVAR(explosionClassNameOverride);
                property = QGVAR(edenModulePropertyCommon_explosionClassNameOverride);
                typeName = "STRING";
                defaultValue = "''";
            };
            class RequiredHits: Edit {
                property = QGVAR(edenModulePropertyCommon_requiredHits);
                displayName = CSTRING(edenModulePropertyCommon_requiredHitsLabel);
                tooltip = CSTRING(edenModulePropertyCommon_requiredHitsTooltip);
                typeName = "NUMBER";
                defaultValue = "'5'";
            };
            class FixedRequiredHits: Checkbox {
                property = QGVAR(edenModulePropertyCommon_fixedRequiredHits);
                displayName = CSTRING(edenModulePropertyCommon_fixedRequiredHitsLabel);
                tooltip = CSTRING(edenModulePropertyCommon_fixedRequiredHitsTooltip);
                typeName = "";
                defaultValue = "false";
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Shot_Vulnerable_Global_DisplayName);
        };
    };

    class GVAR(edenModuleScrollKeypadBomb): GVAR(baseModule) {
        displayName = CSTRING(Module_Scroll_Keypad_Bomb_DisplayName);
        icon = "DBUG\pictures\options.paa";
        function = QFUNC(edenModuleKeypadBomb);
        scope = 2;
        scopeCurator = 0;
        class Attributes: AttributesBase {
            class BombTime: Edit {
                property = QGVAR(edenModuleScrollKeypadBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleScrollKeypadBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class SolutionCode: Edit {
                property = QGVAR(edenModuleScrollKeypadBomb_SolutionCode);
                displayName = CSTRING(SolutionCodeLabel);
                typeName = "STRING";
                defaultValue = "'000000'";
            };
            class SerialNumber: Edit {
                property = QGVAR(edenModuleScrollKeypadBomb_SerialNumber);
                displayName = CSTRING(SerialNumberLabel);
                typeName = "STRING";
                defaultValue = "'Unknown'";
            };
            class ExplosionClassName: Default {
                control = QGVAR(explosionClassName);
                property = QGVAR(edenModulePropertyCommon_explosionClassName);
                typeName = "STRING";
                defaultValue = "'DemoCharge_Remote_Ammo'";
            };
            class ExplosionClassNameOverride: Default {
                control = QGVAR(explosionClassNameOverride);
                property = QGVAR(edenModulePropertyCommon_explosionClassNameOverride);
                typeName = "STRING";
                defaultValue = "''";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModuleScrollKeypadBomb_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Scroll_Keypad_Bomb_DisplayName);
        };
    };

    class GVAR(edenModuleScrollWireBomb): GVAR(baseModule) {
        displayName = CSTRING(Module_Scroll_Wire_Bomb_DisplayName);
        icon = "DBUG\pictures\options.paa";
        function = QFUNC(edenModuleWireBomb);
        scope = 2;
        scopeCurator = 0;
        class Attributes: AttributesBase {
            class BombTime: Edit {
                property = QGVAR(edenModuleScrollWireBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleScrollWireBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class WireSign: Edit {
                property = QGVAR(edenModuleScrollWireBomb_WireSign);
                displayName = CSTRING(WireSignLabel);
                typeName = "STRING";
                defaultValue = "'|'";
            };
            class WireCount: Edit {
                property = QGVAR(edenModuleScrollWireBomb_WireCount);
                displayName = CSTRING(WireCountLabel);
                typeName = "NUMBER";
                defaultValue = "40";
            };
            class ExplosionClassName: Default {
                control = QGVAR(explosionClassName);
                property = QGVAR(edenModulePropertyCommon_explosionClassName);
                typeName = "STRING";
                defaultValue = "'DemoCharge_Remote_Ammo'";
            };
            class ExplosionClassNameOverride: Default {
                control = QGVAR(explosionClassNameOverride);
                property = QGVAR(edenModulePropertyCommon_explosionClassNameOverride);
                typeName = "STRING";
                defaultValue = "''";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModuleScrollKeypadBomb_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Scroll_Wire_Bomb_DisplayName);
        };
    };
};