// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullVehicleUnit.hpp"

switch (_objectUnderCursor getVariable [QGVAR(unlimitedAmmo), false]) do {
	case true: {

		_objectUnderCursor removeEventHandler ["Fired", (_objectUnderCursor getVariable QGVAR(unlimitedAmmoState))];
		[objNull, "UNIT HAS LIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
		_objectUnderCursor setVariable [QGVAR(unlimitedAmmo), false];
		_objectUnderCursor setVariable [QGVAR(unlimitedAmmoState), nil];
	};
	case false: {

		private _unlimitedAmmoEventhandler = _objectUnderCursor addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
		[objNull, "UNIT HAS UNLIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
		_objectUnderCursor setVariable [QGVAR(unlimitedAmmo), true];
		_objectUnderCursor setVariable [QGVAR(unlimitedAmmoState), _unlimitedAmmoEventhandler];
	};
};
