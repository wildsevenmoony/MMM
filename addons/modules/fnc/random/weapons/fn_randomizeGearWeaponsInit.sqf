/*
 * Author: Moony
 * Module: Initializes the Weapons Randomization for each synced unit with predefined selections from corresponding module
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


private _randomizePrimary = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary", false]];
private _forcePrimary = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Primary", false]];
private _contentPrimary = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Content", objNull]];
private _randomizePrimaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope", false]];
private _chancePrimaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Chance", 0]];
private _contentPrimaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Content", objNull]];
private _randomizePrimaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentRailRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail", false]];
private _chancePrimaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentRailChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Chance", 0]];
private _contentPrimaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentRailContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Content", objNull]];
private _randomizePrimaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle", false]];
private _chancePrimaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Chance", 0]];
private _contentPrimaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Content", 0]];
private _randomizePrimaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod", false]];
private _chancePrimaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Chance", 0]];
private _contentPrimaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Content", objNull]];

private _randomizeSidearm = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm", false]];
private _forceSidearm = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Sidearm", false]];
private _contentSidearm = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Content", objNull]];
private _randomizeSidearmScope = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentScopeRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope", false]];
private _chanceSidearmScope = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentScopeChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Chance", 0]];
private _contentSidearmScope = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentScopeContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Content", objNull]];
private _randomizeSidearmRail = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentRailRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail", false]];
private _chanceSidearmRail = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentRailChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Chance", 0]];
private _contentSidearmRail = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentRailContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Content", objNull]];
private _randomizeSidearmMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle", false]];
private _chanceSidearmMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Chance", 0]];
private _contentSidearmMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Content", 0]];
private _randomizeSidearmBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentBipodRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod", false]];
private _chanceSidearmBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentBipodChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Chance", 0]];
private _contentSidearmBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSidearmAttachmentBipodContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Content", objNull]];

private _randomizeSecondary = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary", false]];
private _forceSecondary = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Secondary", false]];
private _contentSecondary = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Content", objNull]];
private _randomizeSecondaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope", false]];
private _chanceSecondaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Chance", 0]];
private _contentSecondaryScope = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Content", objNull]];
private _randomizeSecondaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentRailRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail", false]];
private _chanceSecondaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentRailChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Chance", 0]];
private _contentSecondaryRail = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentRailContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Content", objNull]];
private _randomizeSecondaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle", false]];
private _chanceSecondaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Chance", 0]];
private _contentSecondaryMuzzle = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Content", 0]];
private _randomizeSecondaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod", false]];
private _chanceSecondaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Chance", 0]];
private _contentSecondaryBipod = _logic getVariable [QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Content", objNull]];

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
	] call EFUNC(modules,randomizeGearWeapons);
} forEach _unit;
