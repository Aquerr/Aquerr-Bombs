#include "script_component.hpp"
/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for making a given object an explosive that will explode on bullet hit or nearby explosions.

        Explosion hits randomness:
            When _fixed parameter is not passed or set to false, the script will randomly decide if the object should explode.
            The explosion chance will be increased with each hit, where the maximum chance will be at _requiredHits. 

	Parameter(s):
		0: OBJECT - the object that should be registered as explosive.
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
        [this] call abombs_main_fnc_register_explosive_handlers_for_object
        [this, false, "DemoCharge_Remote_Ammo", 10] call abombs_main_fnc_register_explosive_handlers_for_object
        [this, false, "DemoCharge_Remote_Ammo", 10, true, true] call abombs_main_fnc_register_explosive_handlers_for_object
*/

params ["_object", ["_shouldDeleteWreckAfterExplosion", true, [true]], ["_explosionClassName", "IEDUrbanSmall_Remote_Ammo", ["string"]], ["_requiredHits", 5, [5]], ["_fixed", false, [false]], ["_global", true, [true]]];

if ((isNil "_object") || {isNull(_object)}) exitWith { hint LELSTRING(common,MustSelectObject) };

if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(abombs_register_explosive_handlers_for_object_JIP)}}}}) exitWith {

    private _id = [QGVAR(register_explosive_handlers_for_object), [_object, _shouldDeleteWreckAfterExplosion, _explosionClassName, _requiredHits, _fixed, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(abombs_register_explosive_handlers_for_object_JIP), _id, true];
};

 private _registerEventHandlersFunction = {
    params ["_object", "_shouldDeleteWreckAfterExplosion", "_explosionClassName", "_requiredHits", "_fixed"];

    if (GETVAR(_object,abombs_vulnerable_events_registered,false)) exitWith {};

    TRACE_1("Registering handlers for device",_object);
	
    SETVAR(_object,abombs_vulnerable_events_registered,true);
    SETVAR(_object,aquerr_delete_after_explosion,_shouldDeleteWreckAfterExplosion);
    SETVAR(_object,aquerr_required_hits,_requiredHits);
    SETVAR(_object,aquerr_hit_count_fixed,_fixed);
    SETPVAR(_object,aquerr_explosion_class_name,_explosionClassName);

    _hitPartEventIndex = _object addEventHandler ["HitPart", {
        (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

        _hits = (GETVAR(_target,aquerr_hits,0)) + 1;
        _requiredHits = GETVAR(_target,aquerr_required_hits,3);
        _hitCountFixed = GETVAR(_target,aquerr_hit_count_fixed,false);
        
        _shouldExplode = false;
        if (_hits >= _requiredHits) then {
            _shouldExplode = true;
        };

        if (!_shouldExplode && !_hitCountFixed) then {
            // Random
            _shouldExplode = ((floor random _requiredHits) + 1) <= _hits;
        };

        if (!_shouldExplode) exitWith {
            SETPVAR(_target,aquerr_hits,_hits);
        };

        if (!(alive _target) && {(GETVAR(_target,abombs_vulnerable_events_registered,false)) && {((GETVAR(_target,aquerr_already_exploded,0)) == 1)}}) exitWith {
            [_target] call FUNC(unregister_explosive_handlers);
        };

        if ((GETVAR(_target,aquerr_already_exploded,0)) == 1) exitWith {};
        SETPVAR(_target,aquerr_already_exploded,1);

        _explosionClassName = GETVAR(_target,aquerr_explosion_class_name,IEDUrbanSmall_Remote_Ammo);
        _explosive = createVehicle [_explosionClassName, (getPosATL _target), [], 0, "CAN_COLLIDE"];
        
        _shouldDeleteWreckAfterExplosion = GETVAR(_target,aquerr_delete_after_explosion,true);
        if(_shouldDeleteWreckAfterExplosion) then {
            deleteVehicle _target;
            [_target] remoteExec [QFUNC(removeRegisteredBomb)];
        };
        
        _explosive setDamage 1;
    }];

    _explosionEventIndex = _object addEventHandler ["Explosion", {
        params ["_vehicle", "_damage", "_source"];

        if (!(alive _vehicle) && {(GETVAR(_vehicle,abombs_vulnerable_events_registered,false)) && {((GETVAR(_vehicle,aquerr_already_exploded,0)) == 1)}}) exitWith {
            [_vehicle] call FUNC(unregister_explosive_handlers);
        };

        // Workaround for event being fired multiple times... (don't know why)
        if ((GETVAR(_vehicle,aquerr_already_exploded,0)) == 1) exitWith {};
        SETPVAR(_vehicle,aquerr_already_exploded,1);

        _explosionClassName = GETVAR(_vehicle,aquerr_explosion_class_name,"IEDUrbanSmall_Remote_Ammo");
        _explosive = createVehicle [_explosionClassName, (getPosATL _vehicle), [], 0, "CAN_COLLIDE"];
        
        _shouldDeleteWreckAfterExplosion = GETVAR(_vehicle,aquerr_delete_after_explosion,true);
        if(_shouldDeleteWreckAfterExplosion) then {
            deleteVehicle _vehicle;
            [_vehicle] remoteExec [QFUNC(removeRegisteredBomb)];
        };
        
        _explosive setDamage 1;
    }];

    _object setVariable ["abombs_explosion_event_index", _explosionEventIndex];
    _object setVariable ["abombs_hit_part_event_index", _hitPartEventIndex];

    [_object] call FUNC(addRegisteredBomb);
};

[_object, _shouldDeleteWreckAfterExplosion, _explosionClassName, _requiredHits, _fixed] call _registerEventHandlersFunction;
