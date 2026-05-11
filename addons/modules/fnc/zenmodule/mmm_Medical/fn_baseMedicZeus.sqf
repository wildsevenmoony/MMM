// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

private _condition = _objectUnderCursor getVariable [QGVAR(baseMedic), false];

if (_condition) exitWith {[objNull, "UNIT IS ALREADY A BASE MEDIC"] call BIS_fnc_showCuratorFeedbackMessage;};

// Code
[_objectUnderCursor] call EFUNC(modules,baseMedic);
[objNull, "BASE MEDIC ADDED"] call BIS_fnc_showCuratorFeedbackMessage;
