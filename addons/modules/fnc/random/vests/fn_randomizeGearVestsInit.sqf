params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizeVests = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize", false];
private _forceVests = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Force", false];
private _contentVests = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Content", objNull];
private _chanceVests = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Chance", objNull];

{
	[_x,_randomizeVests,_forceVests,_contentVests,_chanceVests] call MMM_MODULES_fnc_randomizeGearVests;
} forEach _unit;