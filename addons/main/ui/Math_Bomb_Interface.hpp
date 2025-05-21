class GVAR(Math_Bomb_Interface_Dialog) {
    idd = MATH_BOMB_INTERFACE_ID;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),nil)]);
    objects[] = {};
    class controls {
        
    };
};