/*
 * Author: Moony
 * Shows the war crimes notification to all players.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, objNull] call mmm_modules_fnc_warcrimesNotification
 *
 * Public: No
 */
params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "..\checks\fn_placeOnNothing.hpp"

["mmm_notification_warcrimes",[]] remoteExecCall ["bis_fnc_showNotification", allPlayers];
