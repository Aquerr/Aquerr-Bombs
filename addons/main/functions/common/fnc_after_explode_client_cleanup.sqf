params ["_bomb", "_defuser"];

// Clientside cleanup
if (!hasInterface) exitWith {};

_cleanup = _bomb getVariable ["aquerr_bomb_client_cleanup_function", {}];
[_bomb] call _cleanup;