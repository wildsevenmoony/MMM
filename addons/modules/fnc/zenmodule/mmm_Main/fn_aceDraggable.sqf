/*
 * Author: Moony
 * Toggles ACE draggability for the object under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_aceDraggable
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullObject.hpp"
#include "..\checks\fn_placeOnObject.hpp"

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
