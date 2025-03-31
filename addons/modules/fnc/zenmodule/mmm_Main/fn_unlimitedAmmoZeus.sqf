// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullVehicleUnit.hpp"

switch (_objectUnderCursor getVariable ["MMM_var_UnlimitedAmmo", false]) do {
	case true: {

		_objectUnderCursor removeEventHandler ["Fired", (_objectUnderCursor getVariable "MMM_var_UnlimitedAmmoState")];
		[objNull, "UNIT HAS LIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
		_objectUnderCursor setVariable ["MMM_var_UnlimitedAmmo", false];
		_objectUnderCursor setVariable ["MMM_var_UnlimitedAmmoState", nil];
		[objNull, "OBJECT HAS UNLIMITED AMMO"] call BIS_fnc_showCuratorFeedbackMessage;
	};
	case false: {

		_UnlimitedAmmoEventhandler = _objectUnderCursor addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
		[objNull, "UNIT HAS UNLIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
		_objectUnderCursor setVariable ["MMM_var_UnlimitedAmmo", true];
		_objectUnderCursor setVariable ["MMM_var_UnlimitedAmmoState", _UnlimitedAmmoEventhandler];
		[objNull, "OBJECT HAS LIMITED AMMO"] call BIS_fnc_showCuratorFeedbackMessage;
	};
};
