/*
 * Author: Moony
 * Module: Initializes the Full Gear Randomization for each synced unit with predefined selections from corresponding module
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

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
    diag_log format ["[%1] Full gear randomization init for %2 unit(s). Activated: %3", QADDON, count _unit, _activated];
};

// Get values
private _randomizeBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize", false]];
private _forceBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Force", false]];
private _chanceBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Chance", objNull]];
private _contentBackpacks = _logic getVariable [QGVAR(randomizeGearBackpacksContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Content", objNull]];

private _randomizeGoggles = _logic getVariable [QGVAR(randomizeGearGogglesRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize", false]];
private _forceGoggles = _logic getVariable [QGVAR(randomizeGearGogglesForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Force", false]];
private _chanceGoggles = _logic getVariable [QGVAR(randomizeGearGogglesChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Chance", objNull]];
private _contentGoggles = _logic getVariable [QGVAR(randomizeGearGogglesContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Content", objNull]];

private _randomizeHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize", false]];
private _forceHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Force", false]];
private _chanceHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Chance", objNull]];
private _contentHeadgear = _logic getVariable [QGVAR(randomizeGearHeadgearContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Content", objNull]];

private _randomizeUniforms = _logic getVariable [QGVAR(randomizeGearUniformsRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize", false]];
private _forceUniforms = _logic getVariable [QGVAR(randomizeGearUniformsForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Force", false]];
private _chanceUniforms = _logic getVariable [QGVAR(randomizeGearUniformsChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Chance", objNull]];
private _contentUniforms = _logic getVariable [QGVAR(randomizeGearUniformsContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Content", objNull]];

private _randomizeVests = _logic getVariable [QGVAR(randomizeGearVestsRandomize), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize", false]];
private _forceVests = _logic getVariable [QGVAR(randomizeGearVestsForce), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Force", false]];
private _chanceVests = _logic getVariable [QGVAR(randomizeGearVestsChance), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Chance", objNull]];
private _contentVests = _logic getVariable [QGVAR(randomizeGearVestsContent), _logic getVariable ["MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Content", objNull]];

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


// Backpacks
if (_randomizeBackpacks) then {
    {
        [_x,_randomizeBackpacks,_forceBackpacks,_chanceBackpacks,_contentBackpacks] call EFUNC(modules,randomizeGearBackpacks);
    } forEach _unit;
};

// Goggles
if (_randomizeGoggles) then {
    {
        [_x,_randomizeGoggles,_forceGoggles,_chanceGoggles,_contentGoggles] call EFUNC(modules,randomizeGearGoggles);
    } forEach _unit;
};

// Headgear
if (_randomizeHeadgear) then {
    {
        [_x,_randomizeHeadgear,_forceHeadgear,_chanceHeadgear,_contentHeadgear] call EFUNC(modules,randomizeGearHeadgear);
    } forEach _unit;
};

// Uniforms
if (_randomizeUniforms) then {
    {
        [_x,_randomizeUniforms,_forceUniforms,_chanceUniforms,_contentUniforms] call EFUNC(modules,randomizeGearUniforms);
    } forEach _unit;
};

// Vests
if (_randomizeVests) then {
    {
        [_x,_randomizeVests,_forceVests,_chanceVests,_contentVests] call EFUNC(modules,randomizeGearVests);
    } forEach _unit;
};

// Weapons
if (_randomizePrimary || _randomizeSecondary || _randomizeSidearm) then {
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
};
