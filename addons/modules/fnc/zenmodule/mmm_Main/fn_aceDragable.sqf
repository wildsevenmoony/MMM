// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullObject.hpp"
#include "..\checks\fn_placeOnObject.hpp"

// Code
private _canDrag = _objectUnderCursor getVariable ["mmm_var_canDrag", false];

if (_canDrag) then {
	[_objectUnderCursor, false] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable ["mmm_var_canCarry", true, true];
	[objNull, "OBJECT CAN NOT BE DRAGGED ANYMORE"] call BIS_fnc_showCuratorFeedbackMessage;
	
} else {
	[_objectUnderCursor, true, [0, 1, 0], 1] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable ["mmm_var_canCarry", true, true];
	[objNull, "OBJECT CAN NOW BE DRAGGED"] call BIS_fnc_showCuratorFeedbackMessage;
};