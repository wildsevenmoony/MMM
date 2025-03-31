// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "..\checks\fn_placeOnNothing.hpp"

// Code
["mmm_notification_hatesarma",[]] remoteExecCall ["bis_fnc_showNotification", allPlayers];