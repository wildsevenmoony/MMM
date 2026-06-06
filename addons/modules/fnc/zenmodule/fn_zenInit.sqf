/*/////////////////////////////////////////////////
Author: Crowdedlight
			   
File: fn_zeusRegister.sqf
Parameters: none
Return: none

Using the same setup method as JShock in JSHK contamination mod. 

*///////////////////////////////////////////////

//only load for zeus
#include "\z\mmm\addons\modules\script_component.hpp"

if (!hasInterface) exitWith {};

//spawn script to register zen modules
[] spawn
{
	private _moduleList = [] call {

		private _mmmAI = [
			["Toggle AI Stationary",{_this call EFUNC(modules,stationaryAI)}],
			["Toggle Group Stationary",{_this call EFUNC(modules,stationaryGroup)}]
		];

		private _mmmFun = [
			["War Crimes",{_this call EFUNC(modules,warcrimesNotification)}],
			["Zeus Hates Arma",{_this call EFUNC(modules,zeusHatesArma)}],
			["Zeus Hates Playerbase",{_this call EFUNC(modules,zeusHatesPlayerbase)}]
		];

		private _mmmMain = [
			["Toggle Carryable (ACE)",{_this call EFUNC(modules,aceCarryable)}],
			["Toggle Draggable (ACE)",{_this call EFUNC(modules,aceDraggable)}],
			["Add ACE Arsenal",{_this call EFUNC(modules,aceArsenalZeus)}],
			["Destroy without Explosion",{_this call EFUNC(modules,destroyWithoutExplosion)}],
			["Mobile HQ",{_this call EFUNC(modules,mobileHQZeus)}],
			["Set Respawn Time",{_this call EFUNC(modules,respawnTimer)}],
			["Remove Crater Decal",{_this call EFUNC(modules,removeCrater)}],
			["Unlimited Ammo",{_this call EFUNC(modules,unlimitedAmmoZeus)}],
			["Unlimited Fuel",{_this call EFUNC(modules,unlimitedFuelZeus)}]
		];

		private _mmmMedical = [
			["Base Medic",{_this call EFUNC(modules,baseMedicZeus)}],
			["Apply ACE Damage",{_this call EFUNC(modules,aceDamageZeus)}]
		];

		private _mmmInfection = [];
		if (isClass (configFile >> "CfgPatches" >> "MMB_main")) then {
			_mmmInfection = [
				["Infect",{_this call EFUNC(modules,infectionInfectZeus)}],
				["Set Infection Value",{_this call EFUNC(modules,infectionSetValueZeus)}],
				["Cure",{_this call EFUNC(modules,infectionCureZeus)}],
				["Kill Infected",{_this call EFUNC(modules,infectionKillInfectedZeus)}],
				["Toggle Immunity",{_this call EFUNC(modules,infectionImmunityZeus)}],
				["Toxic Area",{_this call EFUNC(modules,toxicAreaZeus)}]
			];
		};

		private _mmmRandom = [
			["Full Gear Randomization",{_this call EFUNC(modules,randomizeGearZeus)}],
			["Backpacks Randomization",{_this call EFUNC(modules,randomizeGearBackpacksGroupZeus)}],
			["Goggles Randomization",{_this call EFUNC(modules,randomizeGearGogglesGroupZeus)}],
			["Headgear Randomization",{_this call EFUNC(modules,randomizeGearHeadgearGroupZeus)}],
			["Uniforms Randomization",{_this call EFUNC(modules,randomizeGearUniformsGroupZeus)}],
			["Vests Randomization",{_this call EFUNC(modules,randomizeGearVestsGroupZeus)}],
			["Weapons Randomization",{_this call EFUNC(modules,randomizeGearWeaponsGroupZeus)}]
		];

		// Demo modules used while developing standalone dialogs.
		/*private _mmmTest = [
			["Dialog Demo",{_this call EFUNC(modules,moduleExample)}]
		];*/

		private _combinedArr = [
			["Moony's Magnificent", _mmmMain],
			["Moony's Magnificent AI", _mmmAI],
			["Moony's Magnificent Fun", _mmmFun],
			["Moony's Magnificent Infection", _mmmInfection],
			["Moony's Magnificent Medical", _mmmMedical],
			["Moony's Magnificent Random", _mmmRandom]
			// ["Moony's Magnificent TEST", _mmmTest]
		] select {(_x select 1) isNotEqualTo []};
		_combinedArr;
	};	

	//registering ZEN custom modules
	{
		_x params ["_category", "_modules"];
		{
			_x params ["_displayName", "_statement"];
			[_category, _displayName, _statement] call zen_custom_modules_fnc_register;
		} forEach _modules;
	} forEach _moduleList;
};
