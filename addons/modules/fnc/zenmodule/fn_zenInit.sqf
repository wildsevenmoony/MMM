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



		private _MMMAI = [
			["Toggle AI Stationary",{_this call MMM_fnc_stationaryAI}],
			["Toggle Group Stationary",{_this call MMM_fnc_stationaryGroup}]
		];

		private _MMMFun = [
			["War Crimes",{_this call MMM_fnc_warcrimesNotification}],
			["Zeus Hates Arma",{_this call MMM_fnc_zeusHatesArma}],
			["Zeus Hates Playerbase",{_this call MMM_fnc_zeusHatesPlayerbase}]
		];

		private _MMMMain = [
			["Toggle Carryable (ACE)",{_this call MMM_fnc_aceCarryable}],
			["Toggle Dragable (ACE)",{_this call MMM_fnc_aceDragable}],
			["Destroy without Explosion",{_this call MMM_fnc_destroyWithoutExplosion}],
			["Remove Crater Decal",{_this call MMM_fnc_removeCrater}],
			["Unlimited Ammo",{_this call MMM_fnc_unlimitedAmmoZeus}],
			["Unlimited Fuel",{_this call MMM_fnc_unlimitedFuelZeus}]
		];

		private _MMMMedical = [
			["Base Medic",{_this call MMM_fnc_baseMedicZeus}]
		];

		_combinedArr = [_MMMMain, _MMMAI, _MMMFun, _MMMMedical];
		_combinedArr;
	};	

	//registering ZEN custom modules
	{
		private _regMain = 
		[
			"PMC MMMinel", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 0);

	{
		private _regAI = 
		[
			"PMC MMMinel AI", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 1);

	{
		private _regFun = 
		[
			"PMC MMMinel Fun", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 2);

	{
		private _regMedical = 
		[
			"PMC MMMinel Medical", 
			(_x select 0), 
			(_x select 1),
			(_x select 2)
		] call zen_custom_modules_fnc_register;
	} forEach (_moduleList select 3);
};