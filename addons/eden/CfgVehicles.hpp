class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Combo;
            class Edit;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

    // Base module
    class GVAR(baseEdenModule): Module_F {
        author = "Aquerr";
        category = QGVAR(ABOMBS);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 0; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 0; // 0 hidden from Zeus
    };

    ///////////////////////////////////////////////////////////////////////////////////
    //EDEN Modules

    class GVAR(edenModuleExplode): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Explode_DisplayName);
        function = QFUNC(edenModuleExplode);
        scope = 2;
        class Attributes: AttributesBase {
            class Delay: Edit {
                property = QGVAR(edenModuleExplode_Delay);
                displayName = CSTRING(DelayLabel);
                tooltip = CSTRING(DelayTooltip);
                typeName = "NUMBER";
                defaultValue = "0";
            };
            class DeleteAfterExplosion: Checkbox {
                property = QGVAR(edenModuleExplode_DeleteAfterExplosion);
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
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Explode_Description);
        };
    };

    class GVAR(edenModuleVulnerableObjects): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Shot_Vulnerable_DisplayName);
        function = QFUNC(edenModuleShotVulnerable);
        scope = 2;
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
            description = CSTRING(Module_Shot_Vulnerable_Description);
        };
    };

    class GVAR(edenModuleKeypadBomb): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Keypad_Bomb_DisplayName);
        function = QFUNC(edenModuleKeypadBomb);
        scope = 2;
        class Attributes: AttributesBase {
            class GuiType: Combo {
                property = QGVAR(edenModuleKeypadBomb_GuiType);
                displayName = CSTRING(GuiTypeLabel);
                typeName = "STRING";
                defaultValue = 0;
                class Values
                {
                    class Standard
                    {
                        name = "STANDARD";
                        value = "STANDARD";
                    };
                    class Classic
                    {
                        name = "CLASSIC";
                        value = "CLASSIC";
                    };
                };
            };
            class BombTime: Edit {
                property = QGVAR(edenModuleKeypadBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleKeypadBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class SolutionCode: Edit {
                property = QGVAR(edenModuleKeypadBomb_SolutionCode);
                displayName = CSTRING(SolutionCodeLabel);
                typeName = "STRING";
                defaultValue = "'000000'";
            };
            class MaxDefuseAttempts: Edit {
                property = QGVAR(edenModulePropertyCommon_MaxDefuseAttempts);
                displayName = CSTRING(MaxDefuseAttemptsLabel);
                tooltip = CSTRING(MaxDefuseAttemptsTooltip);
                typeName = "NUMBER";
                defaultValue = "1";
            };
            class SerialNumber: Edit {
                property = QGVAR(edenModulePropertyCommon_SerialNumber);
                displayName = CSTRING(SerialNumberLabel);
                tooltip = CSTRING(SerialNumberTooltip);
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
                displayName = CSTRING(OverrideExplosionClassLabel);
                tooltip = CSTRING(OverrideExplosionClassLabelTooltip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class RemoveShotVulnerabilityAfterDefuse: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RemoveShotVulnerabilityAfterDefuse);
                displayName = CSTRING(RemoveShotVulnerabilityAfterDefuseLabel);
                tooltip = CSTRING(RemoveShotVulnerabilityAfterDefuseLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequireEOD: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RequireEOD);
                displayName = CSTRING(RequireEODLabel);
                tooltip = CSTRING(RequireEODLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequiredDefusalItems: Edit {
                property = QGVAR(edenModulePropertyCommon_RequiredDefusalItems);
                displayName = CSTRING(RequiredDefusalItemsLabel);
                tooltip = CSTRING(RequiredDefusalItemsLabelTooltip);
                typeName = "STRING";
                defaultValue = "[]";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModulePropertyCommon_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Keypad_Bomb_Description);
        };
    };

    class GVAR(edenModuleWireBomb): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Wire_Bomb_DisplayName);
        function = QFUNC(edenModuleWireBomb);
        scope = 2;
        class Attributes: AttributesBase {
            class BombTime: Edit {
                property = QGVAR(edenModuleWireBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleWireBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class WireSign: Edit {
                property = QGVAR(edenModuleWireBomb_WireSign);
                displayName = CSTRING(WireSignLabel);
                typeName = "STRING";
                defaultValue = "'|'";
            };
            class WireCount: Edit {
                property = QGVAR(edenModuleWireBomb_WireCount);
                displayName = CSTRING(WireCountLabel);
                typeName = "NUMBER";
                defaultValue = "40";
            };
                class MaxDefuseAttempts: Edit {
                property = QGVAR(edenModulePropertyCommon_MaxDefuseAttempts);
                displayName = CSTRING(MaxDefuseAttemptsLabel);
                tooltip = CSTRING(MaxDefuseAttemptsTooltip);
                typeName = "NUMBER";
                defaultValue = "1";
            };
            class ExplosionClassName: Default {
                control = QGVAR(explosionClassName);
                property = QGVAR(edenModulePropertyCommon_explosionClassName);
                displayName = CSTRING(ExplosionClassLabel);
                typeName = "STRING";
                defaultValue = "'DemoCharge_Remote_Ammo'";
            };
            class ExplosionClassNameOverride: Default {
                control = QGVAR(explosionClassNameOverride);
                property = QGVAR(edenModulePropertyCommon_explosionClassNameOverride);
                typeName = "STRING";
                defaultValue = "''";
            };
            class RemoveShotVulnerabilityAfterDefuse: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RemoveShotVulnerabilityAfterDefuse);
                displayName = CSTRING(RemoveShotVulnerabilityAfterDefuseLabel);
                tooltip = CSTRING(RemoveShotVulnerabilityAfterDefuseLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequireEOD: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RequireEOD);
                displayName = CSTRING(RequireEODLabel);
                tooltip = CSTRING(RequireEODLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequiredDefusalItems: Edit {
                property = QGVAR(edenModulePropertyCommon_RequiredDefusalItems);
                displayName = CSTRING(RequiredDefusalItemsLabel);
                tooltip = CSTRING(RequiredDefusalItemsLabelTooltip);
                typeName = "STRING";
                defaultValue = "[]";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModulePropertyCommon_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Wire_Bomb_Description);
        };
    };

    class GVAR(edenModuleMemoryBomb): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Memory_Bomb_DisplayName);
        function = QFUNC(edenModuleMemoryBomb);
        scope = 2;
        class Attributes: AttributesBase {
            class BombTime: Edit {
                property = QGVAR(edenModuleMemoryBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleMemoryBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class RoundsCount: Edit {
                property = QGVAR(edenModuleMemoryBomb_RoundsCount);
                displayName = CSTRING(RoundsCountLabel);
                tooltip = CSTRING(RoundsCountTooltip);
                typeName = "NUMBER";
                defaultValue = "5";
            };
            class MaxDefuseAttempts: Edit {
                property = QGVAR(edenModulePropertyCommon_MaxDefuseAttempts);
                displayName = CSTRING(MaxDefuseAttemptsLabel);
                tooltip = CSTRING(MaxDefuseAttemptsTooltip);
                typeName = "NUMBER";
                defaultValue = "1";
            };
            class SerialNumber: Edit {
                property = QGVAR(edenModulePropertyCommon_SerialNumber);
                displayName = CSTRING(SerialNumberLabel);
                tooltip = CSTRING(SerialNumberTooltip);
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
                displayName = CSTRING(OverrideExplosionClassLabel);
                tooltip = CSTRING(OverrideExplosionClassLabelTooltip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class RemoveShotVulnerabilityAfterDefuse: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RemoveShotVulnerabilityAfterDefuse);
                displayName = CSTRING(RemoveShotVulnerabilityAfterDefuseLabel);
                tooltip = CSTRING(RemoveShotVulnerabilityAfterDefuseLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequireEOD: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RequireEOD);
                displayName = CSTRING(RequireEODLabel);
                tooltip = CSTRING(RequireEODLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequiredDefusalItems: Edit {
                property = QGVAR(edenModulePropertyCommon_RequiredDefusalItems);
                displayName = CSTRING(RequiredDefusalItemsLabel);
                tooltip = CSTRING(RequiredDefusalItemsLabelTooltip);
                typeName = "STRING";
                defaultValue = "[]";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModulePropertyCommon_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Memory_Bomb_Description);
        };
    };

    class GVAR(edenModuleMorseBomb): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_Morse_Bomb_DisplayName);
        function = QFUNC(edenModuleMorseBomb);
        scope = 2;
        class Attributes: AttributesBase {
            class BombTime: Edit {
                property = QGVAR(edenModuleMorseBomb_BombTime);
                displayName = CSTRING(BombTimeLabel);
                tooltip = CSTRING(BombTimeTooltip);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class ShouldBeep: Checkbox {
                property = QGVAR(edenModuleMorseBomb_ShouldBeep);
                displayName = CSTRING(ShouldBeepLabel);
                typeName = "BOOL";
                defaultValue = "true";
            };
            class MaxDefuseAttempts: Edit {
                property = QGVAR(edenModulePropertyCommon_MaxDefuseAttempts);
                displayName = CSTRING(MaxDefuseAttemptsLabel);
                tooltip = CSTRING(MaxDefuseAttemptsTooltip);
                typeName = "NUMBER";
                defaultValue = "1";
            };
            class EncodedMessage: Edit {
                property = QGVAR(edenModuleMorseBomb_EncodedMessage);
                displayName = CSTRING(EncodedMessageLabel);
                tooltip = CSTRING(EncodedMessageTooltip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class SolutionMessage: Edit {
                property = QGVAR(edenModuleMorseBomb_SolutionMessage);
                displayName = CSTRING(SolutionMessageLabel);
                tooltip = CSTRING(SolutionMessageTooltip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class SerialNumber: Edit {
                property = QGVAR(edenModulePropertyCommon_SerialNumber);
                displayName = CSTRING(SerialNumberLabel);
                tooltip = CSTRING(SerialNumberTooltip);
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
                displayName = CSTRING(OverrideExplosionClassLabel);
                tooltip = CSTRING(OverrideExplosionClassLabelTooltip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class RemoveShotVulnerabilityAfterDefuse: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RemoveShotVulnerabilityAfterDefuse);
                displayName = CSTRING(RemoveShotVulnerabilityAfterDefuseLabel);
                tooltip = CSTRING(RemoveShotVulnerabilityAfterDefuseLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequireEOD: Checkbox {
                property = QGVAR(edenModulePropertyCommon_RequireEOD);
                displayName = CSTRING(RequireEODLabel);
                tooltip = CSTRING(RequireEODLabelTooltip);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequiredDefusalItems: Edit {
                property = QGVAR(edenModulePropertyCommon_RequiredDefusalItems);
                displayName = CSTRING(RequiredDefusalItemsLabel);
                tooltip = CSTRING(RequiredDefusalItemsLabelTooltip);
                typeName = "STRING";
                defaultValue = "[]";
            };
            class AfterDefuseCode: Default {
                property = QGVAR(edenModulePropertyCommon_AfterDefuseCode);
                displayName = CSTRING(AfterDefuseCodeLabel);
                tooltip = CSTRING(AfterDefuseCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_Morse_Bomb_Description);
        };
    };
};
