// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

private _condition = _objectUnderCursor getVariable ["mmm_var_BaseMedic", false];

if (_condition) exitWith {[objNull, "UNIT IS ALREADY A BASE MEDIC"] call BIS_fnc_showCuratorFeedbackMessage;};

// Code
[_objectUnderCursor] call mmm_modules_fnc_baseMedic;
[objNull, "BASE MEDIC ADDED"] call BIS_fnc_showCuratorFeedbackMessage;
