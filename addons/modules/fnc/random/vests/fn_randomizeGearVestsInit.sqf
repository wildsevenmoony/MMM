/*
 * Author: Moony
 * Module: Initializes the Vests Randomization for each synced unit with predefined selections from corresponding module
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
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeVests = _logic getVariable [QGVAR(randomizeGearVestsRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize", false]];
private _forceVests = _logic getVariable [QGVAR(randomizeGearVestsForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Force", false]];
private _chanceVests = _logic getVariable [QGVAR(randomizeGearVestsChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Chance", objNull]];
private _contentVests = _logic getVariable [QGVAR(randomizeGearVestsContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Content", objNull]];

{
	[_x,_randomizeVests,_forceVests,_chanceVests,_contentVests] call EFUNC(modules,randomizeGearVests);
} forEach _unit;
