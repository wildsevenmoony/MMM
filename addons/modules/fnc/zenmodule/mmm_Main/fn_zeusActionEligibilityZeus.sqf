/*
 * Author: Moony
 * Enables MMA's Zeus self-action eligibility on the unit under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_zeusActionEligibilityZeus
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

if !(isClass (configFile >> "CfgPatches" >> "mma_main")) exitWith {
	[objNull, "MMA IS NOT LOADED"] call BIS_fnc_showCuratorFeedbackMessage;
};

#include "..\checks\fn_notNullObject.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

_objectUnderCursor setVariable ["MMA_var_zeusActionEligible", true, true];

[objNull, "ZEUS ACTION ADDED TO UNIT"] call BIS_fnc_showCuratorFeedbackMessage;
