// FUNCTION PREPS
PREP_BY_PATH(addRegisteredBomb,functions\fnc_addRegisteredBomb.sqf);
PREP_BY_PATH(removeRegisteredBomb,functions\fnc_removeRegisteredBomb.sqf);

// Shot/Explosion vulnerability
PREP(register_explosive_handlers_global);
PREP(register_explosive_handlers_for_object);
PREP_BY_PATH(unregister_explosive_handlers,functions\common\fnc_unregister_explosive_handlers.sqf);

// Bomb functions
// Common
PREP_BY_PATH(init_bomb_timer,functions\common\fnc_init_bomb_timer.sqf);
PREP_BY_PATH(init_serial_number,functions\common\fnc_init_serial_number.sqf);
PREP_BY_PATH(after_explode_client_cleanup,functions\common\fnc_after_explode_client_cleanup.sqf);
PREP_BY_PATH(bomb_explode,functions\common\fnc_bomb_explode.sqf);
PREP_BY_PATH(bomb_defuse,functions\common\fnc_bomb_defuse.sqf);
PREP_BY_PATH(set_require_eod,functions\common\fnc_set_require_eod.sqf);
PREP_BY_PATH(set_require_defusal_items,functions\common\fnc_set_require_defusal_items.sqf);
PREP_BY_PATH(can_defuse_bomb,functions\common\fnc_can_defuse_bomb.sqf);

// Keypad
PREP_BY_PATH(init_keypad_bomb_full,functions\keypad\fnc_init_keypad_bomb_full.sqf);

PREP_BY_PATH(init_keypad_solution_code,functions\keypad\fnc_init_keypad_solution_code.sqf);
PREP_BY_PATH(init_keypad_actions,functions\keypad\fnc_init_keypad_actions.sqf);
PREP_BY_PATH(init_keypad_gui,functions\keypad\fnc_init_keypad_gui.sqf);
PREP_BY_PATH(keypad_enter_digit,functions\keypad\fnc_keypad_enter_digit.sqf);
PREP_BY_PATH(keypad_clear_entered_code,functions\keypad\fnc_keypad_clear_entered_code.sqf);

PREP_BY_PATH(open_keypad_bomb_interface,functions\keypad\gui\fnc_open_keypad_bomb_interface.sqf);
PREP_BY_PATH(open_classic_keypad_bomb_interface,functions\keypad\gui\fnc_open_classic_keypad_bomb_interface.sqf);

PREP_BY_PATH(gui_keypad_clear_code,functions\keypad\gui\fnc_gui_keypad_clear_code.sqf);
PREP_BY_PATH(gui_keypad_enter_digit,functions\keypad\gui\fnc_gui_keypad_enter_digit.sqf);
PREP_BY_PATH(gui_keypad_classic_view_back_panel,functions\keypad\gui\fnc_gui_classic_keypad_view_back_panel.sqf);
PREP_BY_PATH(gui_keypad_standard_view_back_panel,functions\keypad\gui\fnc_gui_keypad_view_back_panel.sqf);
PREP_BY_PATH(gui_keypad_confirm_entered_code,functions\keypad\gui\fnc_gui_keypad_confirm_entered_code.sqf);

PREP_BY_PATH(keypad_confirm_entered_code,functions\keypad\fnc_keypad_confirm_entered_code.sqf);

// Wire
PREP_BY_PATH(init_wire_bomb_full,functions\wire\fnc_init_wire_bomb_full.sqf);

// Memory
PREP_BY_PATH(open_memory_bomb_interface,functions\memory\gui\fnc_open_memory_bomb_interface.sqf);
PREP_BY_PATH(gui_memory_color_click,functions\memory\gui\fnc_gui_memory_color_click.sqf);
PREP_BY_PATH(gui_memory_bomb_start,functions\memory\gui\fnc_gui_memory_bomb_start.sqf);
PREP_BY_PATH(gui_memory_bomb_play_round,functions\memory\gui\fnc_gui_memory_bomb_play_round.sqf);
PREP_BY_PATH(init_memory_bomb_gui_action,functions\memory\fnc_init_memory_bomb_gui_action.sqf);
PREP_BY_PATH(init_memory_bomb_full,functions\memory\fnc_init_memory_bomb_full.sqf);

// Morse
PREP_BY_PATH(init_morse_bomb_full,functions\morse\fnc_init_morse_bomb_full.sqf);
PREP_BY_PATH(open_morse_bomb_interface,functions\morse\gui\fnc_open_morse_bomb_interface.sqf);
PREP_BY_PATH(init_morse_bomb_gui_action,functions\morse\fnc_init_morse_bomb_gui_action.sqf);
PREP_BY_PATH(gui_morse_bomb_start,functions\morse\gui\fnc_gui_morse_bomb_start.sqf);
PREP_BY_PATH(gui_morse_confirm_code,functions\morse\gui\fnc_gui_morse_bomb_confirm_code.sqf);
