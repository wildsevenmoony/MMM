// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "\Modules\fnc\zenmodule\Checks\fn_notNullVehicleUnit.hpp"

// Code
[_objectUnderCursor] call MMM_fnc_unlimitedAmmo;
