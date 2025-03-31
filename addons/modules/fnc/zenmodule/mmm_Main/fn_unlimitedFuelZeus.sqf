// Get all the passed parameters
params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullVehicle.hpp"
#include "..\checks\fn_placeOnVehicle.hpp"

switch (_objectUnderCursor getVariable ["MMM_var_UnlimitedFuel", false]) do {
	case true: {
		[objNull, "VEHICLE HAS LIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

		_objectUnderCursor setVariable ["MMM_var_UnlimitedFuelState", false];
		_objectUnderCursor setVariable ["MMM_var_UnlimitedFuel", false];
	};

	case false: {
		[objNull, "VEHICLE HAS UNLIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

		[_objectUnderCursor] spawn {
			_objectUnderCursor = _this select 0;

			while {(alive _objectUnderCursor) OR ((_objectUnderCursor getVariable ["MMM_var_UnlimitedFuelState", false]) == false )} do {
				if (fuel _objectUnderCursor < 0.8) then {
						_objectUnderCursor setFuel 1;
				};
				sleep 120;
			};
		};

		_objectUnderCursor setVariable ["MMM_var_UnlimitedFuelState", true];
		_objectUnderCursor setVariable ["MMM_var_UnlimitedFuel", true];
	};
};
