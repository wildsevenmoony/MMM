#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Adds or removes the local scroll-wheel ACE Arsenal action.
 *
 * Arguments:
 * 0: Arsenal object <OBJECT>
 * 1: Add action <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [
	["_object", objNull, [objNull]],
	["_enabled", false, [false]]
];

if (isNull _object) exitWith {};

private _oldAction = _object getVariable [QGVAR(aceArsenalScrollActionId), -1];
if (_oldAction >= 0) then {
	_object removeAction _oldAction;
	_object setVariable [QGVAR(aceArsenalScrollActionId), -1];
};

if (!_enabled) exitWith {};

private _actionId = _object addAction [
	"<img image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\box_ca.paa' /> Open Arsenal",
	{
		params ["_target", "_caller"];
		[
			_target,
			_caller,
			false
		] call ace_arsenal_fnc_openBox;
	},
	nil,
	25,
	true,
	false,
	""
];

_object setVariable [QGVAR(aceArsenalScrollActionId), _actionId];
