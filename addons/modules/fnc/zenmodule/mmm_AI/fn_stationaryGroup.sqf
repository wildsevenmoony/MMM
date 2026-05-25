/*
 * Author: Moony
 * Toggles stationary mode for the group of the unit under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_stationaryGroup
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

private _isStationary = _objectUnderCursor getVariable [QGVAR(aiStationary), false];
private _function = [QEFUNC(modules,stationaryAIStationary), QEFUNC(modules,stationaryAIMoving)] select _isStationary;
private _message = ["GROUP IS STATIONARY", "GROUP CAN MOVE AGAIN"] select _isStationary;

{
	[_x] remoteExec [_function, _x];
} forEach units group _objectUnderCursor;

[objNull, _message] call BIS_fnc_showCuratorFeedbackMessage;
	
