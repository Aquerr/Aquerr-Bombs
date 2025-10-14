#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Open's classic keypad GUI Dialog and setups its fields.

	Parameter(s):
        0: OBJECT - the object that keypad is attached to

	Example:
        [2] call abombs_main_fnc_open_classic_keypad_bomb_interface;
*/

params ["_targetObject"];

if (dialog) then {
    closeDialog 0;
};

GVAR(Interface_Target_Object) = _targetObject;

createDialog QGVAR(Classic_Keypad_Interface_Dialog);

_dialog = findDisplay CLASSIC_KEYPAD_INTERFACE_ID;

 [
	{
		params ["_args", "_handle"];
		_args params ["_dialog", "_targetObject"];

		if (isNull _dialog) exitWith { 
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		_solutionCodeDisplayField = _dialog displayCtrl BOMB_GUI_ENTERED_CODE_FIELD_ID;
		_solutionCodeDisplayField ctrlSetText (_targetObject getVariable ["abombs_keypad_entered_code", ""]);
	}
, 0.25, [_dialog, _targetObject]] call CBA_fnc_addPerFrameHandler;
