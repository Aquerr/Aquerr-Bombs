#include "Constants.hpp"

class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscCombo;
class RscEdit;
class RscXSliderH;
class ctrlToolbox;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(BombMaxDefuseAttemptsControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class BombMaxDefuseAttemptsLabel: RscText {
            idc = -1;
            text = ECSTRING(main,BombMaxDefuseAttemptsLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class BombMaxDefuseAttempts: RscEdit {
            idc = ZEUS_COMMON_DIALOG_MAX_DEFUSE_ATTEMPTS_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(0.0));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            autocomplete = "";
        };
    };
};

class GVAR(BombRemoveShotVulnerabilityAfterDefuseControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class BombRemoveShotVulnerabilityAfterDefuseLabel: RscText {
            idc = -1;
            text = CSTRING(BombRemoveShotVulnerabilityAfterDefuseLabel);
            tooltip = ECSTRING(main,BombRemoveShotVulnerabilityAfterDefuseLabelTooltip);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class BombRemoveShotVulnerabilityAfterDefuse: ctrlToolbox {
            idc = ZEUS_COMMON_DIALOG_REMOVE_SHOT_VULNERABILITY_AFTER_DEFUSE_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(0.0));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            rows = 1;
            columns = 2;
            strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
        };

    };
};

class GVAR(SerialNumberControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class SerialNumberLabel: RscText {
            idc = -1;
            text = ECSTRING(main,serialnumberlabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class SerialNumber: RscEdit {
            idc = ZEUS_COMMON_DIALOG_SERIAL_NUMBER_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(0.0));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            autocomplete = "";
        };
    };
};

class GVAR(BombTimeControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class BombTimeLabel: RscText {
            idc = -1;
            text = ECSTRING(main,BombTimeLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class BombTime: RscEdit {
            idc = ZEUS_COMMON_DIALOG_BOMB_TIME_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(0.0));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            autocomplete = "";
        };
    };
};

class GVAR(ShouldBeepControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class ShouldBeepLabel: RscText {
            text = ECSTRING(main,ShouldBeepLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class ShouldBeepToggle: ctrlToolbox {
            idc = ZEUS_COMMON_DIALOG_SHOULD_BEEP_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(0.0));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            rows = 1;
            columns = 2;
            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
        };
    };
};

class GVAR(ExplosionClassControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(2.2));
    class controls {
        class ExplosionClassLabel: RscText {
            idc = -1;
            text = ECSTRING(main,ExplosionClassLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class ExplosionClass: RscCombo {
            idc = ZEUS_COMMON_DIALOG_EXPLOSION_CLASS_ID;
            x = QUOTE(W_PART(10.1));
            y = 0;
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.7};
            class Items {
                class VERY_BIG_EXPLOSION {
                    text = "ammo_Missile_Cruise_01";
                };
                class BIG_EXPLOSION {
                    text = "helicopterExploBig";
                };
                class MEDIUM_EXPLOSION {
                    text = "DemoCharge_Remote_Ammo";
                };
                class MEDIUM_EXPLOSION_2 {
                    text = "IEDUrbanSmall_Remote_Ammo";
                };
                class SMALL_EXPLOSION {
                    text = "APERSMine_Range_Ammo";
                };
            };
        };
        class OverrideExplosionClassLabel: RscText {
            idc = -1;
            text = ECSTRING(main,OverrideExplosionClassLabel);
            tooltip = ECSTRING(main,OverrideExplosionClassLabelTooltip);
            x = 0;
            y = QUOTE(H_PART(1.1));
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class OverrideExplosionClass: RscEdit {
            idc = ZEUS_COMMON_DIALOG_EXPLOSION_OVERRIDE_EXPLOSION_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(1.1));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            autocomplete = "";
        };
    };
};

class GVAR(DeleteObjectAfterExplosionControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class DeleteWreckAfterExplosionLabel: RscText {
            idc = -1;
            text = ECSTRING(main,DeleteWreckAfterExplosionLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class DeleteWreckAfterExplosionToggle: ctrlToolbox {
            idc = ZEUS_COMMON_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
            x = QUOTE(W_PART(10.1));
            y = 0;
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            rows = 1;
            columns = 2;
            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
        };
    };
};

class GVAR(EodAndItemsRequirementControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(2.2));
    class controls {
        class RequireEodLabel: RscText {
            text = ECSTRING(main,RequireEodLabel);
            x = 0;
            y = 0;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class RequireEodToggle: ctrlToolbox {
            idc = ZEUS_COMMON_DIALOG_REQUIRE_EOD_ID;
            x = QUOTE(W_PART(10.1));
            y = 0;
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            rows = 1;
            columns = 2;
            strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
        };
        class RequiredDefusalItemsLabel: RscText {
            idc = -1;
            text = ECSTRING(main,RequiredDefsualItemsLabel);
            x = 0;
            y = QUOTE(H_PART(1.1));
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(1));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class RequiredDefusalItemsEdit: RscEdit {
            idc = ZEUS_COMMON_DIALOG_REQUIRED_DEFUSAL_ITEMS_EDIT_ID;
            x = QUOTE(W_PART(10.1));
            y = QUOTE(H_PART(1.1));
            w = QUOTE(W_PART(15.9));
            h = QUOTE(H_PART(1));
            autocomplete = "";
        };
    };
};

class GVAR(RscExplode): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscExplode))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscExplode))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class explodeGroup: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_explode));
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(3.3));
                    class controls {
                        class DelayLabel: RscText {
                            idc = ZEUS_EXPLODE_DIALOG_DELAY_EDIT_ID;
                            text = ECSTRING(main,DelayLabel);
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class DelayLabelSlider: RscXSliderH {
                            idc = ZEUS_EXPLODE_DIALOG_DELAY_SLIDER_ID;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class deleteObjectAfterExplosionControls: GVAR(DeleteObjectAfterExplosionControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(2.2));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscShotVulnerable): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscShotVulnerable))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscShotVulnerable))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class shotVulnerableObjectGroup: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_shotVulnerable));
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(3.3));
                    class controls {
                        class deleteObjectAfterExplosionControls: GVAR(DeleteObjectAfterExplosionControls) {};
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscShotVulnerableGlobal): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscShotVulnerableGlobal))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscShotVulnerableGlobal))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class shotVulnerableObjectsGlobalGroup: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_shotVulnerableGlobal));
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(4.4));
                    class controls {
                        class ClassNamesLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,ClassNamesLabel);
                            tooltip = ECSTRING(main,ClassNamesLabelTooltip);
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class ClassNamesEdit: RscEdit {
                            idc = ZEUS_VULNERABLE_OBJECTS_GLOBAL_DIALOG_CLASS_NAMES_ID;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class deleteObjectAfterExplosionControls: GVAR(DeleteObjectAfterExplosionControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(2.2));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscWireBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscWireBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscWireBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class wireBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_WireBomb));
                    idc = ZEUS_WIRE_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(12.12));
                    class controls {
                        class bombTimeControls: GVAR(BombTimeControls) {
                            x = 0;
                            y = 0;
                        };
                        class shouldBeepControls: GVAR(ShouldBeepControls) {
                            x = 0;
                            y = QUOTE(H_PART(1.1));
                        };
                        class WireSignLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,WireSignLabel);
                            x = 0;
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class WireSign: RscEdit {
                            idc = ZEUS_WIRE_BOMB_DIALOG_WIRE_SIGN_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class WireCountLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,WireCountLabel);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class WireCountSlider: RscXSliderH {
                            idc = ZEUS_WIRE_BOMB_DIALOG_WIRE_COUNT_SLIDER_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class WireCountEdit: RscEdit {
                            idc = ZEUS_WIRE_BOMB_DIALOG_WIRE_COUNT_ID;
                            x = QUOTE(W_PART(24.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(1.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                            maxChars = 3;
                            canModify = 0;
                        };
                        class BombMaxDefuseAttemptsControls: GVAR(BombMaxDefuseAttemptsControls) {
                            y = QUOTE(H_PART(4.4));
                        };
                        class SerialNumberControls: GVAR(SerialNumberControls) {
                            y = QUOTE(H_PART(5.5));
                        };
                        class eodAndItemsRequirementControls: GVAR(EodAndItemsRequirementControls) {
                            y = QUOTE(H_PART(6.6));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(8.8));
                        };
                        class BombRemoveShotVulnerabilityAfterDefuseControls: GVAR(BombRemoveShotVulnerabilityAfterDefuseControls) {
                            y = QUOTE(H_PART(11.11));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscKeypadBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscKeypadBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscKeypadBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class keypadBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_KeypadBomb));
                    idc = ZEUS_KEYPAD_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(12.12));
                    class controls {
                        class guiTypeLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,GuiTypeLabel);
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class guiTypeEdit: RscCombo {
                            idc = ZEUS_KEYPAD_BOMB_DIALOG_GUI_TYPE_ID;
                            x = QUOTE(W_PART(10.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            class Items {
                                class CLASSIC {
                                    text = "CLASSIC";
                                };
                                class STANDARD {
                                    text = "STANDARD";
                                };
                            };
                        };
                        class bombTimeControls: GVAR(BombTimeControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class shouldBeepControls: GVAR(ShouldBeepControls) {
                            y = QUOTE(H_PART(2.2));
                        };
                        class SolutionCodeLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,SolutionCodeLabel);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class SolutionCodeEdit: RscEdit {
                            idc = ZEUS_KEYPAD_BOMB_DIALOG_SOLUTION_CODE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class BombMaxDefuseAttemptsControls: GVAR(BombMaxDefuseAttemptsControls) {
                            y = QUOTE(H_PART(4.4));
                        };
                        class SerialNumberControls: GVAR(SerialNumberControls) {
                            y = QUOTE(H_PART(5.5));
                        };
                        class eodAndItemsRequirementControls: GVAR(EodAndItemsRequirementControls) {
                            y = QUOTE(H_PART(6.6));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(8.8));
                        };
                        class BombRemoveShotVulnerabilityAfterDefuseControls: GVAR(BombRemoveShotVulnerabilityAfterDefuseControls) {
                            y = QUOTE(H_PART(11.11));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscMemoryBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscMemoryBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscMemoryBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class memoryBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_MemoryBomb));
                    idc = ZEUS_MEMORY_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(11.11));
                    class controls {
                        class bombTimeControls: GVAR(BombTimeControls) {
                            y = 0;
                        };
                        class shouldBeepControls: GVAR(ShouldBeepControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class RoundsCountLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,RoundsCountLabel);
                            x = 0;
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class RoundsCountEdit: RscEdit {
                            idc = ZEUS_MEMORY_BOMB_DIALOG_ROUNDS_COUNT_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                        };
                        class BombMaxDefuseAttemptsControls: GVAR(BombMaxDefuseAttemptsControls) {
                            y = QUOTE(H_PART(3.3));
                        };
                        class SerialNumberControls: GVAR(SerialNumberControls) {
                            y = QUOTE(H_PART(4.4));
                        };
                        class eodAndItemsRequirementControls: GVAR(EodAndItemsRequirementControls) {
                            y = QUOTE(H_PART(5.5));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(7.7));
                        };
                        class BombRemoveShotVulnerabilityAfterDefuseControls: GVAR(BombRemoveShotVulnerabilityAfterDefuseControls) {
                            y = QUOTE(H_PART(9.9));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscMorseBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscMorseBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscMorseBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class memoryBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_MorseBomb));
                    idc = ZEUS_MORSE_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(11.11));
                    class controls {
                        class bombTimeControls: GVAR(BombTimeControls) {
                            y = 0;
                        };
                        class shouldBeepControls: GVAR(ShouldBeepControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class BombMaxDefuseAttemptsControls: GVAR(BombMaxDefuseAttemptsControls) {
                            y = QUOTE(H_PART(2.2));
                        };
                        class EncodedMessageLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,EncodedMessageLabel);
                            tooltip = ECSTRING(main,EncodedMessageLabelTooltip);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class EncodedMessageEdit: RscEdit {
                            idc = ZEUS_MORSE_BOMB_DIALOG_ENCODED_MESSAGE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class SolutionMessageLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,SolutionMessageLabel);
                            tooltip = ECSTRING(main,SolutionMessageLabelTooltip);
                            x = 0;
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class SolutionMessageEdit: RscEdit {
                            idc = ZEUS_MORSE_BOMB_DIALOG_SOLUTION_MESSAGE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class SerialNumberControls: GVAR(SerialNumberControls) {
                            y = QUOTE(H_PART(5.5));
                        };
                        class eodAndItemsRequirementControls: GVAR(EodAndItemsRequirementControls) {
                            y = QUOTE(H_PART(6.6));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(8.8));
                        };
                        class BombRemoveShotVulnerabilityAfterDefuseControls: GVAR(BombRemoveShotVulnerabilityAfterDefuseControls) {
                            y = QUOTE(H_PART(11.11));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
