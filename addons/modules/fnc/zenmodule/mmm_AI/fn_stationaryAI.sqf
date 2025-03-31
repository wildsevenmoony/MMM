// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

// Toggle AI Stationary
if (_objectUnderCursor getVariable ["mmm_var_AI_Stationary",false]) then {
	[_objectUnderCursor] remoteExec ["mmm_modules_fnc_stationary_ai_moving", _objectUnderCursor];
	[objNull, "AI CAN MOVE AGAIN"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
	[_objectUnderCursor] remoteExec ["mmm_modules_fnc_stationary_ai_stationary", _objectUnderCursor];
	[objNull, "AI IS STATIONARY"] call BIS_fnc_showCuratorFeedbackMessage;
};