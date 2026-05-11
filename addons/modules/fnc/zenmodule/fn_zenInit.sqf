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
			["Toggle Dragable (ACE)",{_this call EFUNC(modules,aceDragable)}],
			["Destroy without Explosion",{_this call EFUNC(modules,destroyWithoutExplosion)}],
			["Set Respawn Time",{_this call EFUNC(modules,respawnTimer)}],
			["Remove Crater Decal",{_this call EFUNC(modules,removeCrater)}],
			["Unlimited Ammo",{_this call EFUNC(modules,unlimitedAmmoZeus)}],
			["Unlimited Fuel",{_this call EFUNC(modules,unlimitedFuelZeus)}]
		];

		private _mmmMedical = [
			["Base Medic",{_this call EFUNC(modules,baseMedicZeus)}]
		];

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

		private _combinedArr = [_mmmMain, _mmmAI, _mmmFun, _mmmMedical, _mmmRandom/*, _mmmTest*/];
		_combinedArr;
	};	

	//registering ZEN custom modules
	{
		[
			"Moonys Magnificent", 
			(_x select 0), 
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 0);

	{
		[
			"Moonys Magnificent AI", 
			(_x select 0), 
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 1);

	{
		[
			"Moonys Magnificent Fun", 
			(_x select 0), 
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 2);

	{
		[
			"Moonys Magnificent Medical", 
			(_x select 0), 
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 3);

	{
		[
			"Moonys Magnificent Random", 
			(_x select 0), 
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 4);

	/*{
		[
			"Moonys Magnificent TEST",
			(_x select 0),
			(_x select 1)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 5);*/
};
