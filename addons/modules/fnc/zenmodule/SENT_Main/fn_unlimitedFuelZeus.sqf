// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_notNullVehicle.hpp"
#include "\Modules\fnc\zenmodule\Checks\fn_placeOnVehicle.hpp"

// Code
[_objectUnderCursor] call MMM_fnc_unlimitedFuel;
