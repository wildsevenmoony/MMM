#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Eden module entry point for ACE Arsenal.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic, synchronizedObjects] call mmm_modules_fnc_aceArsenalInit
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

private _addScrollAction = _logic getVariable [QGVAR(aceArsenalScrollAction), _logic getVariable [QGVAR(arsenalScrollAction), false]];
private _blacklist = _logic getVariable [QGVAR(aceArsenalBlacklist), _logic getVariable [QGVAR(arsenalBlacklist), ""]];
private _limited = _logic getVariable [QGVAR(aceArsenalLimited), false];
private _limitedItems = _logic getVariable [QGVAR(aceArsenalLimitedItems), _logic getVariable [QGVAR(aceArsenalWhitelist), ""]];
private _addCompatibleMagazines = _logic getVariable [QGVAR(aceArsenalAddCompatibleMagazines), false];
private _addCompatibleAttachments = _logic getVariable [QGVAR(aceArsenalAddCompatibleAttachments), false];

[
	_objects,
	_addScrollAction,
	_blacklist,
	_limited,
	_limitedItems,
	_addCompatibleMagazines,
	_addCompatibleAttachments
] call EFUNC(modules,aceArsenal);
