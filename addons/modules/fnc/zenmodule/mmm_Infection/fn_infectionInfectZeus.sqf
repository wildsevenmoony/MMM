/*
 * Author: Moony
 * Infects the unit under the Zeus cursor using MMA.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
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
#include "..\checks\fn_isAlive.hpp"

if !(isNil {_objectUnderCursor getVariable "WBK_AI_ISZombie"}) exitWith {
    [objNull, "ZOMBIES CANNOT BE INFECTED"] call BIS_fnc_showCuratorFeedbackMessage;
};

[_objectUnderCursor] remoteExec ["MMA_fnc_infection", _objectUnderCursor];
[objNull, "UNIT INFECTED"] call BIS_fnc_showCuratorFeedbackMessage;
