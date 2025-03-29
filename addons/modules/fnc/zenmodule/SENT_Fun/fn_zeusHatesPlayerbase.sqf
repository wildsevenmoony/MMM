// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnNothing.hpp"

// Code
//Show Notification
["MMM_notification_zeushatesplayer",[]] remoteExecCall ["bis_fnc_showNotification", allPlayers];