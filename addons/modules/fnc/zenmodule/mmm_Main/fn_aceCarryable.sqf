/*
 * Author: Moony
 * Toggles ACE carryability for the object under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_aceCarryable
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

private _canCarry = _objectUnderCursor getVariable [QGVAR(canCarry), false];

if (_canCarry) then {
	[_objectUnderCursor, false] call ace_dragging_fnc_setCarryable;
	_objectUnderCursor setVariable [QGVAR(canCarry), false, true];
	[objNull, "OBJECT CAN NOT BE CARRIED ANYMORE"] call BIS_fnc_showCuratorFeedbackMessage;
	
} else {
	[_objectUnderCursor, true, [0, 1, 1], 1] call ace_dragging_fnc_setCarryable;
	_objectUnderCursor setVariable [QGVAR(canCarry), true, true];
	[objNull, "OBJECT CAN NOW BE CARRIED"] call BIS_fnc_showCuratorFeedbackMessage;
};
