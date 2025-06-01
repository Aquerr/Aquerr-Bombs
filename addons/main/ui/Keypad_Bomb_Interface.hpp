class RscPicture;

class GVAR(Keypad_Bomb_Interface_Dialog) {
    idd = KEYPAD_BOMB_INTERFACE_ID;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),nil)]);
    objects[] = {};
    class ControlsBackground
	{
        class BombBackground: RscPicture {
            idc = -1;
			x = QUOTE(X_PART(-5));
			y = QUOTE(Y_PART(0));
			w = QUOTE(W_PART(50));
			h = QUOTE(H_PART(25));
            type = 0;
            style = 48;
            size = 0;
            colorBackground[] = {0,0,0,1};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(images\aquerr_bomb_interface.paa);
        };
	};

class controls {
        class ENTERED_CODE: RscText
        {
            idc = BOMB_GUI_ENTERED_CODE_FIELD_ID;
            font="TahomaB";
            text = "0";
            x = QUOTE(X_PART(10));
            y = QUOTE(Y_PART(5));
            w = QUOTE(W_PART(10.0));
            h = QUOTE(H_PART(2.5));
            colorText[] = {1,1,1,1};
            tooltip = "Enter code";
        };

        class TIME_TEXT: RscText
        {
            idc = BOMB_GUI_TIME_LABEL_ID;
            font="TahomaB";
            text = "";
            style = 2;
            x = QUOTE(X_PART(28.5));
            y = QUOTE(Y_PART(5));
            w = QUOTE(W_PART(4.0));
            h = QUOTE(H_PART(1.5));
            colorText[] = {1,1,1,1};
        };

        class DIGIT_1: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(6));
            y = QUOTE(Y_PART(10.5));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 1";
            action = QUOTE([1] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_2: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(11.85));
            y = QUOTE(Y_PART(10.5));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 2";
            action = QUOTE([2] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_3: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(17.85));
            y = QUOTE(Y_PART(10.5));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 3";
            action = QUOTE([3] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_4: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(6));
            y = QUOTE(Y_PART(14.75));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 4";
            action = QUOTE([4] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_5: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(11.85));
            y = QUOTE(Y_PART(14.75));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 5";
            action = QUOTE([5] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_6: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(17.85));
            y = QUOTE(Y_PART(14.75));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 6";
            action = QUOTE([6] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_7: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(6));
            y = QUOTE(Y_PART(19));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 7";
            action = QUOTE([7] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_8: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(11.85));
            y = QUOTE(Y_PART(19));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 8";
            action = QUOTE([8] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_9: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(17.85));
            y = QUOTE(Y_PART(19));
            w = QUOTE(W_PART(5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 9";
            action = QUOTE([9] call FUNC(gui_keypad_enter_digit));
        };
        class CLEAR_CODE: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(23.75));
            y = QUOTE(Y_PART(10.5));
            w = QUOTE(W_PART(3.5));
            h = QUOTE(H_PART(3.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Clear code";
            action = QUOTE(call FUNC(gui_keypad_clear_code));
        };
        class DIGIT_0: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(23.75));
            y = QUOTE(Y_PART(14.75));
            w = QUOTE(W_PART(3.5));
            h = QUOTE(H_PART(7.75));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Enter 0";
            action = QUOTE([0] call FUNC(gui_keypad_enter_digit));
        };

        class CONFIRM_CODE: RscButton
        {
            idc = -1;
            x = QUOTE(X_PART(29.85));
            y = QUOTE(Y_PART(12.05));
            w = QUOTE(W_PART(2.65));
            h = QUOTE(H_PART(2.65));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0,0,0,0.0};
            colorFocused[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            tooltip = "Confirm code";
            action = QUOTE([] call FUNC(gui_keypad_confirm_entered_code));
        };

        class BACK_PANEL: RscButton 
        {
            idc = -1;
            text = "";
            x = QUOTE(X_PART(35.5));
            y = QUOTE(Y_PART(11));
            w = QUOTE(W_PART(1));
            h = QUOTE(H_PART(5.0));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0.3, 0.3, 0.3,0.5};
            tooltip = CSTRING(ViewBackPanel);
            action = QUOTE([GVAR(Bomb_Interface_Target)] call FUNC(gui_keypad_standard_view_back_panel));
        };
    };
};

class GVAR(Keypad_Bomb_Interface_Back_Panel_Dialog) {
    idd = KEYPAD_BOMB_INTERFACE_BACK_PANEL_ID;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),nil)]);
    objects[] = {};
    class ControlsBackground
	{
        class BombBackground: RscPicture {
            idc = -1;
			x = QUOTE(X_PART(-5));
			y = QUOTE(Y_PART(0));
			w = QUOTE(W_PART(50));
			h = QUOTE(H_PART(25));
            type = 0;
            style = 48;
            size = 0;
            colorBackground[] = {0,0,0,1};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(images\aquerr_bomb_interface_back.paa);
        };
	};

    class controls {
        class FRONT_PANEL: RscButton 
        {
            idc = -1;
            text = "";
            x = QUOTE(X_PART(4));
            y = QUOTE(Y_PART(11));
            w = QUOTE(W_PART(1));
            h = QUOTE(H_PART(5.0));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0.3, 0.3, 0.3,0.5};
            tooltip = "View front panel";
            action = QUOTE([GVAR(Bomb_Interface_Target)] call FUNC(open_keypad_bomb_interface));
        };
        class SERIAL_NUMBER: RscText
        {
            idc = BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
            font="TahomaB";
            text = "";
            style = 2;
            x = QUOTE(X_PART(5));
            y = QUOTE(Y_PART(20));
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(2.0));
            sizeEx = 0.025; //Text size
            colorText[] = {1,1,1,1};
            colorBackground[] = {0, 0, 0,0};
        };
    };
};