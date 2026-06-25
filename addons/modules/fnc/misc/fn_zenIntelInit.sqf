#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Eden module entry point for adding Zeus Enhanced style intel to synchronized objects.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Objects <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic, synchronizedObjects logic, true] call mmm_modules_fnc_zenIntelInit
 *
 * Public: No
 */

private _logic = objNull;
private _objects = [];
private _activated = true;

if ((_this param [0, objNull]) isEqualType "") then {
	private _mode = _this param [0, "", [""]];
	private _input = _this param [1, [], [[]]];

	if (_mode != "init" && {!(_mode in ["attributesChanged3DEN", "registeredToWorld3DEN", "connectionChanged3DEN"])}) exitWith {true};

	_input params [
		["_logicInput", objNull, [objNull]],
		["_activatedInput", true, [true]]
	];

	_logic = _logicInput;
	_activated = _activatedInput;
	_objects = synchronizedObjects _logic;

	if (is3DEN) exitWith {true};
} else {
	_this params [
		["_logicInput", objNull, [objNull]],
		["_objectsInput", [], [[]]],
		["_activatedInput", true, [true]]
	];

	_logic = _logicInput;
	_objects = _objectsInput;
	_activated = _activatedInput;
};

if (!_activated || {isNull _logic}) exitWith {};

[
	_objects,
	[
		_logic getVariable [QGVAR(zenIntelShare), 0],
		_logic getVariable [QGVAR(zenIntelDelete), true],
		_logic getVariable [QGVAR(zenIntelActionType), 0],
		_logic getVariable [QGVAR(zenIntelActionText), "Pick Up Intel"],
		_logic getVariable [QGVAR(zenIntelActionSound), 0],
		_logic getVariable [QGVAR(zenIntelDuration), 1],
		_logic getVariable [QGVAR(zenIntelTitle), "Intel"],
		_logic getVariable [QGVAR(zenIntelText), ""]
	]
] call EFUNC(modules,zenIntel);
