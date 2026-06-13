/*
 * Author: Moony
 * Module: Initializes the Headgear Randomization for each synced unit with predefined selections from corresponding module
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
        [_x, _presetId, ["headgear"]] call MMA_fnc_randomizationApplyPreset;
    } forEach _unit;
};

private _randomizeHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize", false]];
private _forceHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Force", false]];
private _chanceHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Chance", objNull]];
private _contentHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Content", objNull]];

{
	[_x,_randomizeHeadgear,_forceHeadgear,_chanceHeadgear,_contentHeadgear] call EFUNC(modules,randomizeGearHeadgear);
} forEach _unit;
