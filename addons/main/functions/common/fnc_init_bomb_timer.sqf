#include "..\script_component.hpp"

params ["_bomb", ["_timeInSeconds", 60, [0]], ["_shouldBeep", true, [true]]];

// Should only run on the server
if (!isServer) exitWith {};

_bomb setVariable ["abombs_bomb_time_seconds", _timeInSeconds, true];
_bomb setVariable ["abombs_bomb_beep_enabled", _shouldBeep, true];

[{
            params ["_args", "_handle"];
            _args params ["_bomb"];

            private _timeLeft = (_bomb getVariable ["abombs_bomb_time_seconds", 0]);
            private _fakeTimer = false;
            if (_timeLeft == 0) then {
                _fakeTimer = true;
            };

            if(!alive _bomb) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            if (!(_bomb getVariable ["abombs_bomb_is_armed", false])) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            if (!(_fakeTimer)) then {
                if (_timeLeft <= 0) exitWith {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    [_bomb, objNull] call FUNC(bomb_explode);
                };
                _timeLeft = _timeLeft - 1;
                _bomb setVariable ["abombs_bomb_time_seconds", _timeLeft, true];
            };

            _shouldBeep = _bomb getVariable ["abombs_bomb_beep_enabled", false];
            if (_shouldBeep && {(count ((_bomb nearEntities ["Man", 50]) select {isPlayer _x})) > 0}) then {
                [_bomb, QGVAR(BombBeep)] remoteExec ["say3D"];
            };

}, 1, [_bomb]] call CBA_fnc_addPerFrameHandler;
