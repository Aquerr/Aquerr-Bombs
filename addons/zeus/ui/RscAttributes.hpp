#include "Constants.hpp"

class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscListbox;
class RscCombo;
class RscEdit;
class RscXSliderH;
class RscCheckBox;
class RscActivePicture;
class RscMapControl;
class RscPicture;
class ctrlToolbox;
class RscButton;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
            class controls;
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(BombTimeControls): RscControlsGroupNoScrollbars {
    idc = -1;
    w = QUOTE(W_PART(26));
    h = QUOTE(H_PART(1.1));
    class controls {
        class BombTimeLabel: RscText {
            idc = -1;
            text = CSTRING(BombTimeLabel);
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
            text = CSTRING(ShouldBeepLabel);
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
            text = CSTRING(ExplosionClassLabel);
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
            text = CSTRING(OverrideExplosionClassLabel);
            tooltip = CSTRING(OverrideExplosionClassLabelTooltip);
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

class GVAR(RscShotVulnerable): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscShotVulnerable))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscShotVulnerable))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class scrollWireBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_shotVulnerable));
                    idc = ZEUS_SHOT_VULNERABLE_OBJECT_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(2.2));
                    class controls {
                        class DeleteWreckAfterExplosionLabel: RscText {
                            idc = -1;
                            text = CSTRING(DeleteWreckAfterExplosionLabel);
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class DeleteWreckAfterExplosionToggle: ctrlToolbox {
                            idc = ZEUS_SHOT_VULNERABLE_OBJECT_DIALOG_DELETE_OBJECT_AFTER_EXPLOSION_ID;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
                        };
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

class GVAR(RscScollWireBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscScollWireBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscScollWireBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class scrollWireBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_scrollWireBomb));
                    idc = ZEUS_SCROLL_WIRE_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(6.6));
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
                            text = CSTRING(WireSignLabel);
                            x = 0;
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class WireSign: RscEdit {
                            idc = ZEUS_SCROLL_WIRE_BOMB_DIALOG_WIRE_SIGN_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class WireCountLabel: RscText {
                            idc = -1;
                            text = CSTRING(WireCountLabel);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class WireCountSlider: RscXSliderH {
                            idc = ZEUS_SCROLL_WIRE_BOMB_DIALOG_WIRE_COUNT_SLIDER_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class WireCountEdit: RscEdit {
                            idc = ZEUS_SCROLL_WIRE_BOMB_DIALOG_WIRE_COUNT_ID;
                            x = QUOTE(W_PART(24.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(1.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                            maxChars = 3;
                            canModify = 0;
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(4.4));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscScollKeypadBomb): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscScollKeypadBomb))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscScollKeypadBomb))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class scrollKeypadBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_scrollKeypadBomb));
                    idc = ZEUS_SCROLL_KEYPAD_BOMB_DIALOG_ID;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(6.6));
                    class controls {
                        class bombTimeControls: GVAR(BombTimeControls) {
                            y = 0;
                        };
                        class shouldBeepControls: GVAR(ShouldBeepControls) {
                            y = QUOTE(H_PART(1.1));
                        };
                        class SolutionCodeLabel: RscText {
                            idc = -1;
                            text = CSTRING(SolutionCodeLabel);
                            x = 0;
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class SolutionCodeEdit: RscEdit {
                            idc = ZEUS_SCROLL_KEYPAD_BOMB_DIALOG_SOLUTION_CODE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class SerialNumberLabel: RscText {
                            idc = -1;
                            text = CSTRING(SerialNumberLabel);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class SerialNumberEdit: RscEdit {
                            idc = ZEUS_SCROLL_KEYPAD_BOMB_DIALOG_SERIAL_NUMBER_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                        };
                        class explosionClassControls: GVAR(ExplosionClassControls) {
                            y = QUOTE(H_PART(4.4));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};