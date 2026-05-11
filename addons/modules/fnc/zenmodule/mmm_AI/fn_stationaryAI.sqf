// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

// Toggle AI Stationary
if (_objectUnderCursor getVariable [QGVAR(aiStationary),false]) then {
	[_objectUnderCursor] remoteExec [QEFUNC(modules,stationaryAIMoving), _objectUnderCursor];
	[objNull, "AI CAN MOVE AGAIN"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
	[_objectUnderCursor] remoteExec [QEFUNC(modules,stationaryAIStationary), _objectUnderCursor];
	[objNull, "AI IS STATIONARY"] call BIS_fnc_showCuratorFeedbackMessage;
};
