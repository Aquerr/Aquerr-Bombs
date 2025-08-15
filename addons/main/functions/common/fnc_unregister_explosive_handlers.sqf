#include "..\script_component.hpp"

params ["_object"];

if ((_object getVariable ["abombs_vulnerable_events_registered", false] == false)) exitWith {};

_object removeEventHandler ["HitPart", _object getVariable "abombs_hit_part_event_index"];
_object removeEventHandler ["Explosion", _object getVariable "abombs_explosion_event_index"];
_object setVariable ["abombs_register_explosive_handlers_for_object_JIP", nil];
_object setVariable ["abombs_vulnerable_events_registered", false];

if ((_object getVariable ["abombs_bomb_is_armed", false]) == false) then {
	[_object] remoteExec [QFUNC(removeRegisteredBomb)];
};
