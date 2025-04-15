private _notNullVehicle = if (isNull _objectUnderCursor) exitWith {
				[objNull, "PLACE ON AN VEHCILE"] call BIS_fnc_showCuratorFeedbackMessage;
			};