#include "script_component.hpp"

[QGVAR(register_explosive_handlers_global), { call FUNC(register_explosive_handlers_global)}] call CBA_fnc_addEventHandler;
[QGVAR(register_explosive_handlers_for_object), { call FUNC(register_explosive_handlers_for_object)}] call CBA_fnc_addEventHandler;
[QGVAR(scroll_action_bomb_hint_text_image), { call FUNC(scroll_action_bomb_hint_text_image)}] call CBA_fnc_addEventHandler;
[QGVAR(init_keypad_bomb), { call FUNC(init_keypad_bomb)}] call CBA_fnc_addEventHandler;
[QGVAR(init_memory_bomb), { call FUNC(init_memory_bomb)}] call CBA_fnc_addEventHandler;

[QGVAR(bomb_explode), { _this call FUNC(after_explode_client_cleanup)}] call CBA_fnc_addEventHandler;