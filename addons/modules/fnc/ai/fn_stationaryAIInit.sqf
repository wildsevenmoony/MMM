/*
 * Author: Moony
 * Eden module entry point for stationary AI.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Object <ARRAY>
 * 2: Active <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic, synchronizedObjects, true] call mmm_modules_fnc_stationaryAIInit
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"
 
params [
	["_logic", objNull,[objNull]],
	["_ai", [], [[]]],
	["_activated",true ,[true]]
];

if (!_activated || {isNull _logic}) exitWith {};

private _condition = _logic getVariable [QGVAR(aiStationaryGroup), _logic getVariable ["MMM_MODULES_Module_AI_Stationary", 0]];
private _units = if (_condition == 0) then {
	private _groupUnits = [];

	{
		_groupUnits append (units group _x);
	} forEach _ai;

	_groupUnits arrayIntersect _groupUnits
} else {
	_ai
};

{
	[_x] remoteExec [QEFUNC(modules,stationaryAIStationary), _x];
} forEach _units;
