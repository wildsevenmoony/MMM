/*
 * Author: Moony
 * Destroys the object under the Zeus cursor without ACE cookoff.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_destroyWithoutExplosion
 *
 * Public: No
 */
params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullObject.hpp"
#include "..\checks\fn_placeOnObject.hpp"

_objectUnderCursor setVariable ["ace_cookoff_enable", false, true];
_objectUnderCursor setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
_objectUnderCursor setDamage [1, false];
[objNull, "OBJECT IS DESTROYED WITHOUT AN EXPLOSION"] call BIS_fnc_showCuratorFeedbackMessage;
