#include "..\..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Confirms entered code in morse bomb. Used from GUI. Should not be used by other mods.

	Example:
        [] call abombs_main_fnc_gui_morse_confirm_code;
*/

params [];

_bomb = GVAR(Bomb_Interface_Target);

private _isArmed = _bomb getVariable ["abombs_bomb_is_armed", false];
if (!_isArmed) exitWith {hint (LLSTRING(BombAlreadyDefused))};

_defuser = player;

_dialog = findDisplay MORSE_BOMB_INTERFACE_ID;
_enteredInputFieldControl = _dialog displayCtrl MORSE_BOMB_INPUT_FIELD_ID;
_enteredCode = ctrlText _enteredInputFieldControl;

if (!([_bomb, _defuser] call FUNC(can_defuse_bomb))) exitWith {
	hint LLSTRING(BombDefuseRequirementsNotMet);
};

_solutionCode = _bomb getVariable ["aquerr_morse_bomb_solution_message", ""];
if (_solutionCode isEqualTo _enteredCode) then {
        [_bomb, _defuser] call FUNC(bomb_defuse);
} else {
	_maxDefuseAttempts = _bomb getVariable ["abombs_bomb_max_defuse_attempts", 1];
	_attempts = (_bomb getVariable ["abombs_bomb_defuse_attempts", 0]) + 1;
	_bomb setVariable ["abombs_bomb_defuse_attempts", _attempts, true];
	if (_attempts >= _maxDefuseAttempts) then {
		[_bomb, _defuser] call FUNC(bomb_explode);
	} else {
		_enteredInputFieldControl ctrlSetText "";
		hint "Bomb still ticks...";
	};
};
