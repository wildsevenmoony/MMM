params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeBackpacks = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize", false];
private _forceBackpacks = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Force", false];
private _contentBackpacks = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Content", objNull];
private _chanceBackpacks = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Chance", objNull];

{
	[_x,_randomizeBackpacks,_forceBackpacks,_contentBackpacks,_chanceBackpacks] call MMM_MODULES_fnc_randomizeGearBackpacks;
} forEach _unit;