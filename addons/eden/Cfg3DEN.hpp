class Cfg3DEN {
    class Attributes {
        class Default;
        class Title: Default {
            class Controls {
                class Title;
            };
        };
        class Combo: Title {
            class Controls: Controls {
                class Title: Title {};
                class Value;
            };
        };
        class Edit: Title {
            class Controls: Controls {
                class Title: Title {};
                class Value;
            };
        };

        class GVAR(explosionClassName): Combo {
            class Controls: Controls {
                class Title: Title {
                    text = CSTRING(ExplosionClassLabel);
                };
                class Value: Value {
                    class Items
                    {
                        class Explosion1 {
                            text = "ammo_Missile_Cruise_01";
                            data = "ammo_Missile_Cruise_01";  
                        };

                        class Explosion2 {
                            text = "helicopterExploBig";
                            data = "helicopterExploBig";  
                        };

                        class Explosion3 {
                            text = "DemoCharge_Remote_Ammo";
                            data = "DemoCharge_Remote_Ammo";  
                        };

                        class Explosion4 {
                            text = "IEDUrbanSmall_Remote_Ammo";
                            data = "IEDUrbanSmall_Remote_Ammo";  
                        };

                        class Explosion5 {
                            text = "APERSMine_Range_Ammo";
                            data = "APERSMine_Range_Ammo";  
                        };
                    };
                };
            };
        };

        class GVAR(explosionClassNameOverride): Edit {
            class Controls: Controls {
                class Title: Title {
                    text = CSTRING(OverrideExplosionClassLabel);
                };
                class Value: Value {
                    text = "";
                };
            };
        };
    };
};