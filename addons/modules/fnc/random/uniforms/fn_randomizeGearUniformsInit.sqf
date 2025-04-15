params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeUniforms = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize", false];
private _forceUniforms = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Force", false];
private _contentUniforms = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Content", objNull];
private _chanceUniforms = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Chance", objNull];

{
	[_x,_randomizeUniforms,_forceUniforms,_contentUniforms,_chanceUniforms] call MMM_MODULES_fnc_randomizeGearUniforms;
} forEach _unit;