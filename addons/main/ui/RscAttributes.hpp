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

class GVAR(RscShootVulnerable): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscShootVulnerable))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscShootVulnerable))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class scrollWireBomb: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_shootVulnerable));
                    idc = 66111;
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
                            idc = 66113;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(0.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
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
                    idc = 66211;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(6.6));
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
                            idc = 66212;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(0.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class ShouldBeepLabel: BombTimeLabel {
                            text = CSTRING(ShouldBeepLabel);
                            y = QUOTE(H_PART(1.1));
                        };
                        class ShouldBeepToggle: ctrlToolbox {
                            idc = 66213;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(1.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
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
                            idc = 66214;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.3));
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
                            idc = 66215;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.4));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class WireCountEdit: RscEdit {
                            idc = 66220;
                            x = QUOTE(W_PART(24.1));
                            y = QUOTE(H_PART(3.4));
                            w = QUOTE(W_PART(1.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                            maxChars = 3;
                            canModify = 0;
                        };
                        class ExplosionClassLabel: RscText {
                            idc = -1;
                            text = CSTRING(ExplosionClassLabel);
                            x = 0;
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class ExplosionClass: RscCombo {
                            idc = 66216;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(4.5));
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
                                class SMALL_EXPLOSION {
                                    text = "APERSMine_Range_Ammo";
                                };
                            };
                        };
                        class OverrideExplosionClassLabel: RscText {
                            idc = -1;
                            text = CSTRING(ExplosionClassLabel);
                            x = 0;
                            y = QUOTE(H_PART(5.5));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class OverrideExplosionClass: RscEdit {
                            idc = 66217;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(5.5));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
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
                    idc = 66311;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(5.5));
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
                            idc = 66312;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(0.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                        class ShouldBeepLabel: BombTimeLabel {
                            text = CSTRING(ShouldBeepLabel);
                            y = QUOTE(H_PART(1.1));
                        };
                        class ShouldBeepToggle: ctrlToolbox {
                            idc = 66313;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(1.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
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
                            idc = 66314;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.3));
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
                            idc = 66315;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.4));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class ExplosionClassLabel: RscText {
                            idc = -1;
                            text = CSTRING(ExplosionClassLabel);
                            x = 0;
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class ExplosionClass: RscCombo {
                            idc = 66216;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(4.5));
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
                            y = QUOTE(H_PART(5.5));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class OverrideExplosionClass: RscEdit {
                            idc = 66217;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(5.5));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            autocomplete = "";
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};