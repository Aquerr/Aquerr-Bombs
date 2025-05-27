#include "script_component.hpp"

[QGVAR(register_explosive_handlers_global), { call FUNC(register_explosive_handlers_global)}] call CBA_fnc_addEventHandler;
[QGVAR(register_explosive_handlers_for_object), { call FUNC(register_explosive_handlers_for_object)}] call CBA_fnc_addEventHandler;
[QGVAR(init_wire_bomb_full), { call FUNC(init_wire_bomb_full)}] call CBA_fnc_addEventHandler;
[QGVAR(init_keypad_bomb_full), { call FUNC(init_keypad_bomb_full)}] call CBA_fnc_addEventHandler;
[QGVAR(init_memory_bomb_full), { call FUNC(init_memory_bomb_full)}] call CBA_fnc_addEventHandler;

[QGVAR(bomb_explode), { _this call FUNC(after_explode_client_cleanup)}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    GVARMAIN(registeredBombs) = [];
};