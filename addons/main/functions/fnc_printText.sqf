#include "script_component.hpp"

params ["_logic"];

systemChat "Hello There!";
[objNull, "Printed text!"] call BIS_fnc_showCuratorFeedbackMessage;

deleteVehicle _logic;