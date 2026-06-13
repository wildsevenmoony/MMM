/*
 * Author: Moony
 * Module: Initializes the Goggle Randomization for each synced unit with predefined selections from corresponding module
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

private _usePreset = _logic getVariable [QGVAR(randomizeGearUsePreset), false];
private _presetId = _logic getVariable [QGVAR(randomizeGearPreset), ""];

if (_usePreset && {_presetId isNotEqualTo ""} && {!isNil "MMA_fnc_randomizationApplyPreset"}) exitWith {
    {
        [_x, _presetId, ["goggles"]] call MMA_fnc_randomizationApplyPreset;
    } forEach _unit;
};

private _randomizeGoggles = _logic getVariable [QGVAR(randomizeGearGogglesRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize", false]];
private _forceGoggles = _logic getVariable [QGVAR(randomizeGearGogglesForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Force", false]];
private _chanceGoggles = _logic getVariable [QGVAR(randomizeGearGogglesChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Chance", objNull]];
private _contentGoggles = _logic getVariable [QGVAR(randomizeGearGogglesContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Content", objNull]];

{
	[_x,_randomizeGoggles,_forceGoggles,_chanceGoggles,_contentGoggles] call EFUNC(modules,randomizeGearGoggles);
} forEach _unit;
