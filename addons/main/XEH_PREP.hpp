// FUNCTION PREPS
PREP(register_explosive_handlers_global);
PREP(register_explosive_handlers_for_object);
PREP_BY_PATH(init_keypad_bomb_full,functions\keypad\fnc_init_keypad_bomb_full.sqf);
PREP_BY_PATH(init_wire_bomb_full,functions\wire\fnc_init_wire_bomb_full.sqf);

// GUI open actions
PREP(open_classic_keypad_bomb_interface);
PREP(open_keypad_bomb_interface);

// GUI Buttons
PREP_BY_PATH(gui_bomb_clear_code,functions\gui\fnc_gui_bomb_clear_code.sqf);
PREP_BY_PATH(gui_bomb_enter_digit,functions\gui\fnc_gui_bomb_enter_digit.sqf);
PREP_BY_PATH(gui_classic_keypad_bomb_view_back_panel,functions\gui\fnc_gui_classic_keypad_bomb_view_back_panel.sqf);
PREP_BY_PATH(gui_keypad_bomb_view_back_panel,functions\gui\fnc_gui_keypad_bomb_view_back_panel.sqf);

// Bomb functions
// Common
PREP_BY_PATH(init_bomb_timer,functions\common\fnc_init_bomb_timer.sqf);
PREP_BY_PATH(init_serial_number,functions\common\fnc_init_serial_number.sqf);
PREP_BY_PATH(after_explode_client_cleanup,functions\common\fnc_after_explode_client_cleanup.sqf);
PREP_BY_PATH(bomb_explode,functions\common\fnc_bomb_explode.sqf);

// Keypad
PREP_BY_PATH(init_keypad_solution_code,functions\keypad\fnc_init_keypad_solution_code.sqf);
PREP_BY_PATH(init_keypad_actions,functions\keypad\fnc_init_keypad_actions.sqf);
PREP_BY_PATH(init_keypad_gui,functions\keypad\fnc_init_keypad_gui.sqf);
PREP_BY_PATH(bomb_enter_digit,functions\keypad\fnc_bomb_enter_digit.sqf);
PREP_BY_PATH(bomb_clear_entered_code,functions\fnc_bomb_clear_entered_code.sqf);

// Memory
PREP_BY_PATH(open_memory_bomb_interface,functions\memory\fnc_open_memory_bomb_interface.sqf);
PREP_BY_PATH(gui_memory_color_click,functions\memory\gui\fnc_gui_memory_color_click.sqf);
PREP_BY_PATH(gui_memory_bomb_start,functions\memory\gui\fnc_gui_memory_bomb_start.sqf);
PREP_BY_PATH(gui_memory_bomb_play_round,functions\memory\gui\fnc_gui_memory_bomb_play_round.sqf);
PREP_BY_PATH(init_memory_bomb_gui_action,functions\memory\fnc_init_memory_bomb_gui_action.sqf);
PREP_BY_PATH(init_memory_bomb_full,functions\memory\fnc_init_memory_bomb_full.sqf);