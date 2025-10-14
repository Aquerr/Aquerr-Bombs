#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _solutionCode = _logic getVariable ["SolutionCode", "000000"];
private _serialNumber = _logic getVariable ["SerialNumber", "Unknown"];
private _afterSuccessCode = compile (_logic getVariable ["AfterSuccessCode", '{}']);

private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _initKeypadFunction = {
	_this call EFUNC(main,init_keypad_full);
};

{
	private _keypadParams = [
		_x, 
		_solutionCode, 
		_serialNumber, 
		_afterSuccessCode
	];
	
	_keypadParams call _initKeypadFunction;
} forEach _connectedObjects;
