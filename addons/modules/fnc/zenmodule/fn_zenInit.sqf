/*/////////////////////////////////////////////////
Author: Crowdedlight
			   
File: fn_zeusRegister.sqf
Parameters: none
Return: none

Using the same setup method as JShock in JSHK contamination mod. 

*///////////////////////////////////////////////

//only load for zeus
if (!hasInterface) exitWith {};

//spawn script to register zen modules
private _wait = [] spawn
{
	private _moduleList = [] call {



		private _mmmAI = [
			["Toggle AI Stationary",{_this call mmm_modules_fnc_stationaryAI}],
			["Toggle Group Stationary",{_this call mmm_modules_fnc_stationaryGroup}]
		];

		private _mmmFun = [
			["War Crimes",{_this call mmm_modules_fnc_warcrimesNotification}],
			["Zeus Hates Arma",{_this call mmm_modules_fnc_zeusHatesArma}],
			["Zeus Hates Playerbase",{_this call mmm_modules_fnc_zeusHatesPlayerbase}]
		];

		private _mmmMain = [
			["Toggle Carryable (ACE)",{_this call mmm_modules_fnc_aceCarryable}],
			["Toggle Dragable (ACE)",{_this call mmm_modules_fnc_aceDragable}],
			["Destroy without Explosion",{_this call mmm_modules_fnc_destroyWithoutExplosion}],
			["Remove Crater Decal",{_this call mmm_modules_fnc_removeCrater}],
			["Unlimited Ammo",{_this call mmm_modules_fnc_unlimitedAmmoZeus}],
			["Unlimited Fuel",{_this call mmm_modules_fnc_unlimitedFuelZeus}]
		];

		private _mmmMedical = [
			["Base Medic",{_this call mmm_modules_fnc_baseMedicZeus}]
		];

		private _combinedArr = [_mmmMain, _mmmAI, _mmmFun, _mmmMedical];
		_combinedArr;
	};	

	//registering ZEN custom modules
	{
		private _regMain = 
		[
			"Moonys Magnificent", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 0);

	{
		private _regAI = 
		[
			"Moonys Magnificent AI", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 1);

	{
		private _regFun = 
		[
			"Moonys Magnificent Fun", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 2);

	{
		private _regMedical = 
		[
			"Moonys Magnificent Medical", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 3);
};