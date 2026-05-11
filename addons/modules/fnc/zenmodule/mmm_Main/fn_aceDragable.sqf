// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullObject.hpp"
#include "..\checks\fn_placeOnObject.hpp"

// Code
private _canDrag = _objectUnderCursor getVariable [QGVAR(canDrag), false];

if (_canDrag) then {
	[_objectUnderCursor, false] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable [QGVAR(canDrag), false, true];
	[objNull, "OBJECT CAN NOT BE DRAGGED ANYMORE"] call BIS_fnc_showCuratorFeedbackMessage;
	
} else {
	[_objectUnderCursor, true, [0, 1, 0], 1] call ace_dragging_fnc_setDraggable;
	_objectUnderCursor setVariable [QGVAR(canDrag), true, true];
	[objNull, "OBJECT CAN NOW BE DRAGGED"] call BIS_fnc_showCuratorFeedbackMessage;
};
