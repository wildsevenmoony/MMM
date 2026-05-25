/*
 * Author: Moony
 * Toggles periodic fuel refills for the vehicle under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, vehicle player] call mmm_modules_fnc_unlimitedFuelZeus
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullVehicle.hpp"
#include "..\checks\fn_placeOnVehicle.hpp"

if (_objectUnderCursor getVariable [QGVAR(unlimitedFuel), false]) then {
	[objNull, "VEHICLE HAS LIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

	_objectUnderCursor setVariable [QGVAR(unlimitedFuelState), false];
	_objectUnderCursor setVariable [QGVAR(unlimitedFuel), false];
} else {
	[objNull, "VEHICLE HAS UNLIMITED FUEL"] call BIS_fnc_showCuratorFeedbackMessage;

	[_objectUnderCursor] spawn {
		params ["_objectUnderCursor"];

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
