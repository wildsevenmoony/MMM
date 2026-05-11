/*
 * Author: Moony
 * Module: Initializes the Uniforms Randomization for each synced unit with predefined selections from corresponding module
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


private _randomizeUniforms = _logic getVariable [QGVAR(randomizeGearUniformsRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize", false]];
private _forceUniforms = _logic getVariable [QGVAR(randomizeGearUniformsForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Force", false]];
private _chanceUniforms = _logic getVariable [QGVAR(randomizeGearUniformsChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Chance", objNull]];
private _contentUniforms = _logic getVariable [QGVAR(randomizeGearUniformsContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Content", objNull]];

{
	[_x,_randomizeUniforms,_forceUniforms,_chanceUniforms,_contentUniforms] call EFUNC(modules,randomizeGearUniforms);
} forEach _unit;
