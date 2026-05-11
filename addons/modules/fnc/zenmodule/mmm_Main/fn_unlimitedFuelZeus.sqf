// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullVehicle.hpp"
#include "..\checks\fn_placeOnVehicle.hpp"

switch (_objectUnderCursor getVariable [QGVAR(unlimitedFuel), false]) do {
	case true: {
		[objNull, "VEHICLE HAS LIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

		_objectUnderCursor setVariable [QGVAR(unlimitedFuelState), false];
		_objectUnderCursor setVariable [QGVAR(unlimitedFuel), false];
	};

	case false: {
		[objNull, "VEHICLE HAS UNLIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

		[_objectUnderCursor] spawn {
			private _objectUnderCursor = _this select 0;

			while {(alive _objectUnderCursor) && {_objectUnderCursor getVariable [QGVAR(unlimitedFuelState), false]}} do {
				if (fuel _objectUnderCursor < 0.8) then {
						_objectUnderCursor setFuel 1;
				};
				sleep 120;
			};
		};

		_objectUnderCursor setVariable [QGVAR(unlimitedFuelState), true];
		_objectUnderCursor setVariable [QGVAR(unlimitedFuel), true];
	};
};
