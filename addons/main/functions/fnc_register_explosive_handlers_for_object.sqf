/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for making a given object an explosive that will explode on bullet hit or nearby explosions.

        Explosion hits randomness:
            _fixed parameter is not passed or set to false, the script will randomly decide if the object should explode.
            The chance will increase with each hit where the maximum change will be at _requiredHits. 

	Parameter(s):
		0: OBJECT - the object that should be registered as explosive.
        1: BOOL - if the wreck should be deleted after explosion.
        2: NUMBER - the number of required hits.
        3: BOOLEAN - whether the number of hits is fixed or random (it is random by default).

	Example:
        [this] execVM "register_explosive_handlers_for_object.sqf"
        [this, false, 10] execVM "register_explosive_handlers_for_object.sqf"
        [this, false, 10, true] execVM "register_explosive_handlers_for_object.sqf"
*/

params ["_object", ["_shouldDeleteWreckAfterExplosion", true, [true]], ["_requiredHits", 5, [5]], ["_fixed", false, [false]]];

if ((isNil "_object") || isNull(_object)) exitWith { hint "You must select an object!" };

_requiredHits = 5;
_fxied = false;

 private _registerEventHandlersFunction = {
    params ["_device", "_shouldDeleteWreckAfterExplosion", "_requiredHits", "_fixed"];

    if (_device getVariable ["aquerr_vulnerable_events_registered", false]) exitWith {};

    _device setVariable ["aquerr_vulnerable_events_registered", true];
    _device setVariable ["aquerr_delete_after_explosion", _shouldDeleteWreckAfterExplosion];
    _device setVariable ["aquerr_required_hits", _requiredHits];
    _device setVariable ["aquerr_hit_count_fixed", _fixed];

    _hitPartEventIndex = _device addEventHandler ["HitPart", {
        (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

        _hits = (_target getVariable ["aquerr_hits", 0]) + 1;
        _requiredHits = _target getVariable ["aquerr_required_hits", 3];
        _hitCountFixed = _target getVariable ["aquerr_hit_count_fixed", false];
        
        _shouldExplode = false;
        if (_hits >= _requiredHits) then {
            _shouldExplode = true;
        };

        if (!_shouldExplode && !_hitCountFixed) then {
            // Random
            _shouldExplode = ((floor random _requiredHits) + 1) <= _hits;
        };

        if (!_shouldExplode) exitWith {
            _target setVariable ["aquerr_hits", _hits];
        };

        if (!(alive _target) && {(_target getVariable ["aquerr_vulnerable_events_registered", false])}) then {
            _target removeEventHandler ["HitPart", _target getVariable "aquerr_hit_part_event_index"];
            _target removeEventHandler ["Explosion", _target getVariable "aquerr_explosion_event_index"];
            _target setVariable ["aquerr_vulnerable_events_registered", false];
        };

        _explosionClassName = "IEDUrbanSmall_Remote_Ammo";
        _explosive = createVehicle [_explosionClassName, (getPosATL _target), [], 0, "CAN_COLLIDE"];

        _shouldDeleteWreckAfterExplosion = _target getVariable ["aquerr_delete_after_explosion", true];
        if(_shouldDeleteWreckAfterExplosion) then {
            deleteVehicle _target;
        };

        _explosive setDamage 1;
    }];

    _explosionEventIndex = _device addEventHandler ["Explosion", {
        params ["_vehicle", "_damage", "_source"];

        // Workaround for event being fired multiple times... (don't know why)
        if (_vehicle getVariable ["already_exploded", 0] == 1) exitWith {};
        _vehicle setVariable ["already_exploded", 1];

        if (!(alive _vehicle) && {(_vehicle getVariable ["aquerr_vulnerable_events_registered", false])}) then {
            _vehicle removeEventHandler ["HitPart", _vehicle getVariable "aquerr_hit_part_event_index"];
            _vehicle removeEventHandler ["Explosion", _vehicle getVariable "aquerr_explosion_event_index"];
            _vehicle setVariable ["aquerr_vulnerable_events_registered", false];
        };

        _explosionClassName = "IEDUrbanSmall_Remote_Ammo";
        _explosive = createVehicle [_explosionClassName, (getPosATL _vehicle), [], 0, "CAN_COLLIDE"];

        _shouldDeleteWreckAfterExplosion = _vehicle getVariable ["aquerr_delete_after_explosion", true];
        if(_shouldDeleteWreckAfterExplosion) then {
            deleteVehicle _vehicle;
        };

        _explosive setDamage 1;
    }];

    _device setVariable ["aquerr_explosion_event_index", _explosionEventIndex];
    _device setVariable ["aquerr_hit_part_event_index", _hitPartEventIndex];
 };

[_object, _shouldDeleteWreckAfterExplosion, _requiredHits, _fixed] call _registerEventHandlersFunction;