// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_notNullObject.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnObject.hpp"

// Code
_canDrag = _objectUnderCursor getVariable ["MMM_var_canDrag", false];

if (_canDrag) then {
	[_objectUnderCursor, false] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable ["MMM_var_canCarry", true, true];
	[objNull, "OBJECT CAN NOT BE DRAGGED ANYMORE"] call BIS_fnc_showCuratorFeedbackMessage;
	
} else {
	[_objectUnderCursor, true, [0, 1, 0], 0] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable ["MMM_var_canCarry", true, true];
	[objNull, "OBJECT CAN NOW BE DRAGGED"] call BIS_fnc_showCuratorFeedbackMessage;
};