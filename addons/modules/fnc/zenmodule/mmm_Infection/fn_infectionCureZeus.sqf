/*
 * Author: Moony
 * Cures the unit under the Zeus cursor using MMA.
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

[_objectUnderCursor] remoteExecCall ["MMA_fnc_infectionCleanup", 2];
[objNull, "UNIT CURED"] call BIS_fnc_showCuratorFeedbackMessage;
