params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeHeadgear = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize", false];
private _forceHeadgear = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Force", false];
private _contentHeadgear = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Content", objNull];
private _chanceHeadgear = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Chance", objNull];

{
	[_x,_randomizeHeadgear,_forceHeadgear,_contentHeadgear,_chanceHeadgear] call MMM_MODULES_fnc_randomizeGearHeadgear;
} forEach _unit;