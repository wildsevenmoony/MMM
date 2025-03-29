// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_notNullUnit.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnUnit.hpp"

// Toggle AI Stationary
if (_objectUnderCursor getVariable ["MMM_var_AI_Stationary",false]) then {
	[_objectUnderCursor] remoteexec ["MMM_fnc_stationary_ai_moving", _objectUnderCursor];
	[objNull, "AI CAN MOVE AGAIN"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
	[_objectUnderCursor] remoteexec ["MMM_fnc_stationary_ai_stationary", _objectUnderCursor];
	[objNull, "AI IS STATIONARY"] call BIS_fnc_showCuratorFeedbackMessage;
};


		
		