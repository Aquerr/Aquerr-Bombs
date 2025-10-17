#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
		Script for making all scenario objects (determined by their class names) explode on hits and nearby explosions.

        Explosion hits randomness:
            When _fixed parameter is not passed or set to false, the script will randomly decide if the object should explode.
            The explosion chance will be increased with each hit, where the maximum chance will be at _requiredHits. 

	Parameter(s):
		0: ARRAY - the array of class names to register as explosive objects.
        1: BOOL - if the wreck should be deleted after explosion.
        2: STRING - optional, the explosion class name to use
            // "ammo_Missile_Cruise_01" (very big)
            // "helicopterExploBig" (big)
            // "DemoCharge_Remote_Ammo" (medium)
            // "IEDUrbanSmall_Remote_Ammo" (medium with small fire effect)
            // "APERSMine_Range_Ammo" (small)
        3: NUMBER - optional, the number of required hits. Default: 5
        4: BOOLEAN - whether the number of hits is fixed or random. Default: random
        5: BOOLEAN - if initialize script globally.

	Example:
        [["Land_MetalBarrel_F", "Land_GasTank_02_F", "Barrel1"]] call abombs_main_fnc_register_explosive_handlers_global;
        [["Land_MetalBarrel_F", "Land_GasTank_02_F", "Barrel1"], false] call abombs_main_fnc_register_explosive_handlers_global;
        [["Land_MetalBarrel_F", "Land_GasTank_02_F", "Barrel1"], false, "DemoCharge_Remote_Ammo", 10, true, true] call abombs_main_fnc_register_explosive_handlers_global;
*/

params [["_explosiveObjectsClassNames", [], [[]]], ["_shouldDeleteWreckAfterExplosion", true, [true]], ["_explosionClassName", "IEDUrbanSmall_Remote_Ammo", ["string"]], ["_requiredHits", 5, [5]], ["_fixed", false, [false]], ["_global", true, [true]]];

TRACE_1("_explosiveObjectsClassNames",str _explosiveObjectsClassNames);

_explosiveObjects = allMissionObjects "";
_explosiveObjectsFiltered = [];

{
    _explosiveObject = _x;
	_objectType = typeOf _explosiveObject;
	_isExplosive = _explosiveObjectsClassNames findIf {_x isEqualTo _objectType} > -1;
	if (_isExplosive) then {
		_explosiveObjectsFiltered pushBack _explosiveObject;
	};
} forEach _explosiveObjects;

{
	[_x, _shouldDeleteWreckAfterExplosion, _explosionClassName, _requiredHits, _fixed, _global] call FUNC(register_explosive_handlers_for_object);
} forEach _explosiveObjectsFiltered;

_explosiveObjectsFiltered = nil;
_explosiveObjects = nil;
