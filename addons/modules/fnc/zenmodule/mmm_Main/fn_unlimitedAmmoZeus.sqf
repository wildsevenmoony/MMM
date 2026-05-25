/*
 * Author: Moony
 * Toggles a fired event handler that refills ammo for the selected unit or vehicle.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_unlimitedAmmoZeus
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullVehicleUnit.hpp"

if (_objectUnderCursor getVariable [QGVAR(unlimitedAmmo), false]) then {
	_objectUnderCursor removeEventHandler ["Fired", (_objectUnderCursor getVariable QGVAR(unlimitedAmmoState))];
	[objNull, "UNIT HAS LIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
	_objectUnderCursor setVariable [QGVAR(unlimitedAmmo), false];
	_objectUnderCursor setVariable [QGVAR(unlimitedAmmoState), nil];
} else {
	private _unlimitedAmmoEventhandler = _objectUnderCursor addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
	[objNull, "UNIT HAS UNLIMITED AMMO NOW"] call BIS_fnc_showCuratorFeedbackMessage;
	_objectUnderCursor setVariable [QGVAR(unlimitedAmmo), true];
	_objectUnderCursor setVariable [QGVAR(unlimitedAmmoState), _unlimitedAmmoEventhandler];
};
