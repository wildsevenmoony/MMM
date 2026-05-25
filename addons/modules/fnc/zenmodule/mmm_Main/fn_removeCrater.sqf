/*
 * Author: Moony
 * Hides the nearest crater decal at the Zeus module position.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, objNull] call mmm_modules_fnc_removeCrater
 *
 * Public: No
 */
params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "..\checks\fn_placeOnNothing.hpp"

nearestObject [_position, "#crater"] hideObject true;
[objNull, "CRATER REMOVED"] call BIS_fnc_showCuratorFeedbackMessage;
