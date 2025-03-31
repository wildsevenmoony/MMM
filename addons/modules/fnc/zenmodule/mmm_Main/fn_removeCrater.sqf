// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_doNotPlaceOnObjectUnit.hpp"
#include "..\checks\fn_placeOnNothing.hpp"

// Code
nearestObject [_position, "#crater"] hideObject true;
[objNull, "CRATER REMOVES"] call BIS_fnc_showCuratorFeedbackMessage;
