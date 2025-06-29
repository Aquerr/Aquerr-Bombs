#include "..\script_component.hpp"	

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Defuses the bomb. Local only.

	Parameter(s):
		0: OBJECT - the bomb
        1: OBJECT - the defuser player, can be objNull.

	Example:
        [_bomb, _player] call abombs_main_fnc_bomb_defuse;
*/

params ["_bomb", "_defuser"];

_bomb setVariable ["abombs_bomb_is_armed", false, true];
hint LLSTRING(BombDefused);
[_bomb, QGVAR(BombDefuse)] remoteExec ["say3D"];

_removeVulnerabilityAfterDefuse = _bomb getVariable ["abombs_bomb_remove_shot_vulnerability_after_defuse", false];
if (_removeVulnerabilityAfterDefuse) then {
	[_bomb] call FUNC(unregister_explosive_handlers);
};

[QGVAR(BombDefused), [_bomb, _defuser]] call CBA_fnc_globalEvent;


_afterDefuseFunction = _object getVariable ["abombs_bomb_after_defuse_function", {}];
[_object, _user] call _afterDefuseFunction; 

_clientCleanUpFunction = _object getVariable ["abombs_bomb_client_cleanup_function", {}];
[_object, _user] call _clientCleanUpFunction;