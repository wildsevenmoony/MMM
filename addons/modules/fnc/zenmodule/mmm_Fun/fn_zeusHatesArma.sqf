/*
 * Author: Moony
 * Shows the Zeus hates Arma notification to all players.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, objNull] call mmm_modules_fnc_zeusHatesArma
 *
 * Public: No
 */
params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "..\checks\fn_placeOnNothing.hpp"

["mmm_notification_hatesarma",[]] remoteExecCall ["bis_fnc_showNotification", allPlayers];
