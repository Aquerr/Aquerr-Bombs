#include "script_component.hpp"

[QGVAR(register_explosive_handlers_for_object), { call FUNC(register_explosive_handlers_for_object)}] call CBA_fnc_addEventHandler;
[QGVAR(scroll_action_bomb_hint_text_image), { call FUNC(scroll_action_bomb_hint_text_image)}] call CBA_fnc_addEventHandler;
[QGVAR(scroll_action_keypad_bomb), { call FUNC(scroll_action_keypad_bomb)}] call CBA_fnc_addEventHandler;