// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

// Toggle Group Stationary
if (_objectUnderCursor getVariable ["mmm_var_AI_Stationary",false]) then {
	{
		[_x] remoteExec ["mmm_modules_fnc_stationary_ai_moving", _x];
	} forEach units group _objectUnderCursor;
	[objNull, "GROUP CAN MOVE AGAIN"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
	{
		[_x] remoteExec ["mmm_modules_fnc_stationary_ai_stationary", _x];
	} forEach units group _objectUnderCursor;
	[objNull, "GROUP IS STATIONARY"] call BIS_fnc_showCuratorFeedbackMessage;
};















	