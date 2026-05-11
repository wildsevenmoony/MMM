/*
 * Author: Moony
 * Module: Initializes the Backpack Randomization for each synced unit with predefined selections from corresponding module
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


private _randomizeBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize", false]];
private _forceBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Force", false]];
private _chanceBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Chance", objNull]];
private _contentBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Content", objNull]];

{
	[_x,_randomizeBackpacks,_forceBackpacks,_chanceBackpacks,_contentBackpacks] call EFUNC(modules,randomizeGearBackpacks);
} forEach _unit;
