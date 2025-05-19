params ["_bomb", ["_solutionCode", "0000", ["string"]]];

if (!isServer) exitWith {};

_bomb setVariable ["aquerr_bomb_solution_code", _solutionCode, true];