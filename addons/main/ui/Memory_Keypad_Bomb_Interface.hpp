class GVAR(Memory_Bomb_Interface_Dialog) {
    idd = MEMORY_BOMB_INTERFACE_ID;
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

        class TIME_FRAME: RscFrame
        {
            idc = -1;
            text = "";
            x = 0.44;
            y = 0.1;
            w = QUOTE(W_PART(4.0));
            h = QUOTE(H_PART(1.5));
        };
        class TIME_TEXT: RscText
        {
            idc = BOMB_GUI_TIME_LABEL_ID;
            font="TahomaB";
            text = "";
            style = 2;
            x = 0.44;
            y = 0.10;
            w = QUOTE(W_PART(4.0));
            h = QUOTE(H_PART(1.5));
            colorText[] = {1,1,1,1};
        };

        class Background: RscText {
            idc = -1;
            x = 0.3; 
            y = 0.3;
            w = 0.4; 
            h = 0.4;
            colorBackground[] = {0, 0, 0, 0.7};
        };

        class BtnHidden: RscButton {
            idc = MEMORY_BOMB_BUTTON_HIDDEN_ID;
            text = "";
            x = 0.10; 
            y = 0.31;
            w = 0.1; 
            h = 0.1;
            colorBackground[] = {0, 0, 0, 0.0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorFocused[] = {0, 0, 0, 0.0};
            colorFocused2[] = {0, 0, 0, 0.0};
            colorActive[] = {0,0,0,0};
            action = "";
        };

        class BtnRed: RscButton {
            idc = MEMORY_BOMB_BUTTON_RED_ID;
            text = "";
            x = 0.31; 
            y = 0.31;
            w = 0.18; 
            h = 0.18;
            colorBackground[] = {1, 0, 0, 0.8};
            colorBackgroundActive[] = {1, 0, 0, 1};
            colorFocused[] = {1, 0, 0, 0.8};
            colorFocused2[] = {1, 0, 0, 0.8};
            colorActive[] = {0,0,0,0};
            action = QUOTE([0] call FUNC(gui_memory_color_click));
            soundClick[] = {QPATHTOF(sounds\memory_button.ogg), 1, 0.6};
        };

        class BtnGreen: RscButton {
            idc = MEMORY_BOMB_BUTTON_GREEN_ID;
            text = "";
            x = 0.51;
            y = 0.31;
            w = 0.18; 
            h = 0.18;
            colorBackground[] = {0, 1, 0, 0.8};
            colorBackgroundActive[] = {0, 1, 0, 1};
            colorFocused[] = {0, 1, 0, 0.8};
            colorFocused2[] = {0, 1, 0, 0.8};
            colorActive[] = {0,0,0,0};
            action = QUOTE([1] call FUNC(gui_memory_color_click));
            soundClick[] = {QPATHTOF(sounds\memory_button.ogg), 1, 0.7};
        };

        class BtnBlue: RscButton {
            idc = MEMORY_BOMB_BUTTON_BLUE_ID;
            text = "";
            x = 0.31; 
            y = 0.51;
            w = 0.18; 
            h = 0.18;
            colorBackground[] = {0, 0, 1, 0.8};
            colorBackgroundActive[] = {0, 0, 1, 1};
            colorFocused[] = {0, 0, 1, 0.8};
            colorFocused2[] = {0, 0, 1, 0.8};
            colorActive[] = {0,0,0,0};
            action = QUOTE([2] call FUNC(gui_memory_color_click));
            soundClick[] = {QPATHTOF(sounds\memory_button.ogg), 1, 0.8};
        };

        class BtnYellow: RscButton {
            idc = MEMORY_BOMB_BUTTON_YELLOW_ID;
            text = "";
            x = 0.51; 
            y = 0.51;
            w = 0.18; 
            h = 0.18;
            colorBackground[] = {1, 1, 0, 0.8};
            colorBackgroundActive[] = {1, 1, 0, 1};
            colorFocused[] = {1, 1, 0, 0.8};
            colorFocused2[] = {1, 1, 0, 0.8};
            colorActive[] = {0,0,0,0};
            action = QUOTE([3] call FUNC(gui_memory_color_click));
            soundClick[] = {QPATHTOF(sounds\memory_button.ogg), 1, 0.9};
        };

        class SERIAL_NUMBER: RscText
        {
            idc = BOMB_GUI_SERIAL_NUMBER_FIELD_ID;
            font="TahomaB";
            text = "";
            style = 2;
            x = QUOTE(X_PART(12));
            y = QUOTE(Y_PART(24));
            w = QUOTE(W_PART(10));
            h = QUOTE(H_PART(2.0));
            sizeEx = 0.025; //Text size
            colorText[] = {1,1,1,1};
            colorBackground[] = {0, 0, 0,0};
        };
    };
};
