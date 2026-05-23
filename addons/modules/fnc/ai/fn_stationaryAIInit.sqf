/*
 * Author: Moony
 * Module: Initializes the Stationary AI Script
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Object <ARRAY>
 * 2: Active <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"
 
params [
	["_logic", objNull,[objNull]],
	["_ai", [], [[]]],
	["_activated",true ,[true]]
];

private _condition = _logic getVariable [QGVAR(aiStationaryGroup), _logic getVariable ["MMM_MODULES_Module_AI_Stationary", 0]];

switch (_condition) do {
	case 0: {
		{
			{
				[_x] remoteExec [QEFUNC(modules,stationaryAIStationary), _x];
			} forEach units group _x;
		} forEach _ai;
	};
	case 1: {
		{
			[_x] remoteExec [QEFUNC(modules,stationaryAIStationary), _x];
		} forEach _ai;
	};
};
