//TODO: Make controls positions being calculated based on screen resolution.

class GVAR(Classic_Keypad_Interface_Dialog) {
    idd = CLASSIC_KEYPAD_INTERFACE_ID;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),nil)]);
    objects[] = {};
    class ControlsBackground
	{
		class background2: RscText
		{
			idc = -1;
			x = 0.20;
			y = 0;
			w = QUOTE(W_PART(20));
			h = QUOTE(H_PART(28));
            type = 0;
            style = 80;
            colorBackground[] = {0.1, 0.1, 0.1, 1};
		};
	};

    class controls {
        class DISPLAY_FRAME: RscFrame
        {
            idc = -1;
            text = "";
            x = 0.35;
            y = 0.3;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(3));
        };
        class ENTERED_CODE: RscText
        {
            idc = BOMB_GUI_ENTERED_CODE_FIELD_ID;
            font="TahomaB";
            text = "0";
            x = 0.36;
            y = 0.31;
            w = QUOTE(W_PART(6.1));
            h = QUOTE(H_PART(2.5));
            colorText[] = {1,1,1,1};
            tooltip = CSTRING(EnterCode);
        };

        class KEYPAD_FRAME: RscFrame
        {
            idc = 1801;
            font="TahomaB";
            x = 0.35;
            y = 0.45;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(13));
        };
        class DIGIT_1: RscButton
        {
            idc = -1;
            text = "1";
            x = 0.370;
            y = 0.475;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_1);
            action = QUOTE([1] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_2: RscButton
        {
            idc = -1;
            text = "2";
            x = 0.460;
            y = 0.475;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_2);
            action = QUOTE([2] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_3: RscButton
        {
            idc = -1;
            text = "3";
            x = 0.550;
            y = 0.475;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_3);
            action = QUOTE([3] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_4: RscButton
        {
            idc = -1;
            text = "4";
            x = 0.370;
            y = 0.60;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_4);
            action = QUOTE([4] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_5: RscButton
        {
            idc = -1;
            text = "5";
            x = 0.460;
            y = 0.60;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_5);
            action = QUOTE([5] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_6: RscButton
        {
            idc = -1;
            text = "6";
            x = 0.550;
            y = 0.60;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_6);
            action = QUOTE([6] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_7: RscButton
        {
            idc = -1;
            text = "7";
            x = 0.370;
            y = 0.725;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_7);
            action = QUOTE([7] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_8: RscButton
        {
            idc = -1;
            text = "8";
            x = 0.460;
            y = 0.725;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_8);
            action = QUOTE([8] call FUNC(gui_keypad_enter_digit));
        };
        class DIGIT_9: RscButton
        {
            idc = -1;
            text = "9";
            x = 0.550;
            y = 0.725;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_9);
            action = QUOTE([9] call FUNC(gui_keypad_enter_digit));
        };
        class CLEAR_CODE: RscButton
        {
            idc = -1;
            text = "CLEAR";
            x = 0.370;
            y = 0.85;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(clearcode);
            action = QUOTE(call FUNC(gui_keypad_clear_code));
        };
        class DIGIT_0: RscButton
        {
            idc = -1;
            text = "0";
            x = 0.460;
            y = 0.85;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(Enter_0);
            action = QUOTE([0] call FUNC(gui_keypad_enter_digit));
        };

        class CONFIRM_CODE: RscButton
        {
            idc = -1;
            text = "CONFIRM";
            x = 0.550;
            y = 0.85;
            w = QUOTE(W_PART(2.5));
            h = QUOTE(H_PART(2.5));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0,0.5};
            tooltip = CSTRING(ConfirmCode);
            action = QUOTE([] call FUNC(gui_keypad_confirm_entered_code));
        };

        class BACK_PANEL: RscButton 
        {
            idc = -1;
            text = "";
            x = 0.75;
            y = 0.5;
            w = QUOTE(W_PART(1));
            h = QUOTE(H_PART(5.0));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0.3, 0.3, 0.3,0.5};
            tooltip = CSTRING(ViewBackPanel);
            action = QUOTE([ARR_2(GVAR(Interface_Target_Object),QQGVAR(Classic_Keypad_Interface_Back_Panel_Dialog))] call FUNC(open_classic_keypad_back_panel_interface));
        };
    };
};

class GVAR(Classic_Keypad_Interface_Back_Panel_Dialog) {
    idd = CLASSIC_KEYPAD_INTERFACE_BACK_PANEL_ID;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Bomb_Interface_Dialog),nil)]);
    objects[] = {};
    class ControlsBackground
	{
		class background2: RscText
		{
			idc = -1;
			x = 0.20;
			y = 0;
			w = QUOTE(W_PART(20));
			h = QUOTE(H_PART(28));
            type = 0;
            style = 80;
            colorBackground[] = {0.1, 0.1, 0.1, 1};
		};
	};

    class controls {
        class FRONT_PANEL: RscButton 
        {
            idc = -1;
            text = "";
            x = 0.2;
            y = 0.5;
            w = QUOTE(W_PART(1));
            h = QUOTE(H_PART(5.0));
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {0.3, 0.3, 0.3,0.5};
            tooltip = CSTRING(ViewFrontPanel);
            action = QUOTE([GVAR(Interface_Target_Object)] call FUNC(open_classic_keypad_interface));
        };
        class SERIAL_NUMBER: RscText
        {
            idc = BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
            font="TahomaB";
            text = "";
            style = 2;
            x = 0.35;
            y = 0.9;
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(2.0));
            sizeEx = 0.025; //Text size
            colorText[] = {1,1,1,1};
            colorBackground[] = {0.2, 0.2, 0.2,0.3};
        };
    };
};
