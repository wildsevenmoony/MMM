params [
	["_logic", objNull,[objNull]],
	["_unit", [], [[]]],
	["_activated",true ,[true]]
];


private _randomizePrimary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary", false];
private _forcePrimary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Primary", false];
private _contentPrimary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Content", objNull];
private _randomizePrimaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope", false];
private _chancePrimaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Chance", 0];
private _contentPrimaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Content", objNull];
private _randomizePrimaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail", false];
private _chancePrimaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Chance", 0];
private _contentPrimaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Content", objNull];
private _randomizePrimaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle", false];
private _chancePrimaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Chance", 0];
private _contentPrimaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Content", 0];
private _randomizePrimaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod", false];
private _chancePrimaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Chance", 0];
private _contentPrimaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Content", objNull];

private _randomizeSidearm = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm", false];
private _forceSidearm = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Sidearm", false];
private _contentSidearm = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Content", objNull];
private _randomizeSidearmScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope", false];
private _chanceSidearmScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Chance", 0];
private _contentSidearmScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Content", objNull];
private _randomizeSidearmRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail", false];
private _chanceSidearmRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Chance", 0];
private _contentSidearmRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Content", objNull];
private _randomizeSidearmMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle", false];
private _chanceSidearmMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Chance", 0];
private _contentSidearmMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Content", objNull];
private _randomizeSidearmBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod", false];
private _chanceSidearmBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Chance", 0];
private _contentSidearmBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Content", objNull];

private _randomizeSecondary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary", false];
private _forceSecondary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Secondary", false];
private _contentSecondary = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Content", objNull];
private _randomizeSecondaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope", false];
private _chanceSecondaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Chance", 0];
private _contentSecondaryScope = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Content", objNull];
private _randomizeSecondaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail", false];
private _chanceSecondaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Chance", 0];
private _contentSecondaryRail = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Content", objNull];
private _randomizeSecondaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle", false];
private _chanceSecondaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Chance", 0];
private _contentSecondaryMuzzle = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Content", objNull];
private _randomizeSecondaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod", false];
private _chanceSecondaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Chance", 0];
private _contentSecondaryBipod = _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Content", objNull];

{
	[
		_x,
		_randomizePrimary,
		_forcePrimary,
		_contentPrimary,
		_randomizePrimaryScope,
		_chancePrimaryScope,
		_contentPrimaryScope,
		_randomizePrimaryRail,
		_chancePrimaryRail,
		_contentPrimaryRail,
		_randomizePrimaryMuzzle,
		_chancePrimaryMuzzle,
		_contentPrimaryMuzzle,
		_randomizePrimaryBipod,
		_chancePrimaryBipod,
		_contentPrimaryBipod,
		_randomizeSidearm,
		_forceSidearm,
		_contentSidearm,
		_randomizeSidearmScope,
		_chanceSidearmScope,
		_contentSidearmScope,
		_randomizeSidearmRail,
		_chanceSidearmRail,
		_contentSidearmRail,
		_randomizeSidearmMuzzle,
		_chanceSidearmMuzzle,
		_contentSidearmMuzzle,
		_randomizeSidearmBipod,
		_chanceSidearmBipod,
		_contentSidearmBipod,
		_randomizeSecondary,
		_forceSecondary,
		_contentSecondary,
		_randomizeSecondaryScope,
		_chanceSecondaryScope,
		_contentSecondaryScope,
		_randomizeSecondaryRail,
		_chanceSecondaryRail,
		_contentSecondaryRail,
		_randomizeSecondaryMuzzle,
		_chanceSecondaryMuzzle,
		_contentSecondaryMuzzle,
		_randomizeSecondaryBipod,
		_chanceSecondaryBipod,
		_contentSecondaryBipod
	] call MMM_MODULES_fnc_randomizeGearWeapons;
} forEach _unit;