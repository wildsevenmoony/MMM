/*
 * Author: Moony
 * Marks the unit under the Zeus cursor as infected and kills it using MMA variables.
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

private _legDamage = (_objectUnderCursor getHitPointDamage "HitLeftLeg") max (_objectUnderCursor getHitPointDamage "HitRightLeg");
private _headDamage = _objectUnderCursor getHitPointDamage "HitHead";

_objectUnderCursor setVariable ["MMA_main_infected", true, true];
_objectUnderCursor setVariable ["MMA_main_infectionLevel", 1, true];
_objectUnderCursor setVariable ["MMA_main_infectionReanimatePending", true, true];
_objectUnderCursor setVariable ["MMA_main_infectionReanimateLegDamage", _legDamage, true];
_objectUnderCursor setVariable ["MMA_main_infectionReanimateHeadDamage", _headDamage, true];
_objectUnderCursor setDamage 1;

[objNull, "INFECTED UNIT KILLED"] call BIS_fnc_showCuratorFeedbackMessage;
