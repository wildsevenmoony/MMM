params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeGoggles = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize", false];
private _forceGoggles = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Force", false];
private _contentGoggles = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Content", objNull];
private _chanceGoggles = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Chance", objNull];

{
	[_x,_randomizeGoggles,_forceGoggles,_contentGoggles,_chanceGoggles] call MMM_MODULES_fnc_randomizeGearGoggles;
} forEach _unit;