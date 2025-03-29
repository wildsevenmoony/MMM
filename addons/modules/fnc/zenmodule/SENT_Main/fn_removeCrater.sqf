// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnNothing.hpp"

// Code
nearestObject [_position, "#crater"] hideObject true;
[objNull, "CRATER REMOVES"] call BIS_fnc_showCuratorFeedbackMessage;
