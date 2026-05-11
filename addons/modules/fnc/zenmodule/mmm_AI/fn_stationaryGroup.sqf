// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

// Toggle Group Stationary
if (_objectUnderCursor getVariable [QGVAR(aiStationary),false]) then {
	{
		[_x] remoteExec [QEFUNC(modules,stationaryAIMoving), _x];
	} forEach units group _objectUnderCursor;
	[objNull, "GROUP CAN MOVE AGAIN"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
	{
		[_x] remoteExec [QEFUNC(modules,stationaryAIStationary), _x];
	} forEach units group _objectUnderCursor;
	[objNull, "GROUP IS STATIONARY"] call BIS_fnc_showCuratorFeedbackMessage;
};















	
