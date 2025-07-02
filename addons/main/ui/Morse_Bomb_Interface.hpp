class RscEdit;

class GVAR(Morse_Bomb_Interface_Dialog) {
    idd = MORSE_BOMB_INTERFACE_ID;
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

        class BtnHidden: RscButton {
            idc = MORSE_BOMB_BUTTON_HIDDEN_ID;
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

        class Lamp: RscText {
            idc = MORSE_BOMB_LAMP_ID;
            text = "";
            x = 0.41; 
            y = 0.31;
            w = 0.18; 
            h = 0.18;
            colorBackground[] = {1, 1, 0, 0.8};
            colorBackgroundActive[] = {1, 1, 0, 1};
            colorFocused[] = {1, 1, 0, 0.8};
            colorFocused2[] = {1, 1, 0, 0.8};
            colorActive[] = {0,0,0,0};
        };

        class EnteredCodeInputField: RscEdit {
            idc = MORSE_BOMB_INPUT_FIELD_ID;
            text = "";
            x = 0.36; 
            y = 0.61;
            w = 0.28; 
            h = 0.10;
            style = 2;
            colorBackground[] = {0, 0, 0, 0.7};
            colorBackgroundActive[] = {0, 0, 0, 0.7};
            colorFocused[] = {0, 0, 0, 0.0};
            colorFocused2[] = {0, 0, 0, 0.0};
            colorActive[] = {0,0,0,0};
        };

        class BtnConfirm: RscButton {
            idc = MORSE_BOMB_BUTTON_CONFIRM_ID;
            text = "Confirm";
            x = 0.44; 
            y = 0.75;
            w = 0.11; 
            h = 0.11;
            sizeEx = 0.03; //Text size
            type=1;
            colorBackground[] = {1, 0, 0, 0.8};
            colorBackgroundActive[] = {1, 0, 0, 1};
            colorFocused[] = {1, 0, 0, 1};
            colorFocused2[] = {1, 0, 0, 1};
            colorActive[] = {0,0,0,0};
            tooltip = "Confirm";
            action = QUOTE([] call FUNC(gui_morse_confirm_code));
        };

        class SERIAL_NUMBER: RscText {
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
