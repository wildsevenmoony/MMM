// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_notNullUnit.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnUnit.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_isAlive.hpp"

// Code
[_objectUnderCursor] call MMM_fnc_baseMedic;
[objNull, "BASE MEDIC ADDED"] call BIS_fnc_showCuratorFeedbackMessage;
