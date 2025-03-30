#include "script_component.hpp"

// if not a player we don't do anything
if (!hasInterface) exitWith {}; 

// zeus modules
// private _moduleList = [
//     ["Print Text",{_this call FUNC(printText)}, QPATHTOF(data\tp.paa)],
//     ["Wire Bomb",{_this call FUNC(create_scroll_action_bomb_with_image)}, QPATHTOF(data\tp.paa)],
//     ["Keypad Bomb",{_this call FUNC(create_scroll_action_keypad_bomb)}, QPATHTOF(data\tp.paa)],
//     ["Make object vulnerable to shoot", {_this call FUNC(create_shoot_vulnerable_object)}, QPATHTOF(data\tp.paa)]
// ];

// {
//     [
//         "N-Bombs", 
// 		(_x select 0), 
// 		(_x select 1), 
// 		(_x select 2)
//     ] call zen_custom_modules_fnc_register;
// } forEach _moduleList;