class CfgFunctions
{
	class MMM_MODULES
	{
		class Ai
		{
			file = "z\mmm\addons\modules\fnc\ai";
			class stationaryAIStationary{};
			class stationaryAIMoving{};
			class stationaryAIInit{};
		};
		class Ambient
		{
			file = "z\mmm\addons\modules\fnc\ambient";
			class ambientAnimationMP{};
			class animation{};
		};
		class Medical
		{
			file = "z\mmm\addons\modules\fnc\medical";
			class baseMedic{};
			class baseMedicInit{};
		};
		class Misc
		{
			file = "z\mmm\addons\modules\fnc\misc";
			class spawnWreck{};
		};
		class Random_Backpacks
		{
			file = "z\mmm\addons\modules\fnc\random\backpacks";
			class randomizeGearBackpacks{};
			class randomizeGearBackpacksInit{};
		};
		class Random_Goggles
		{
			file = "z\mmm\addons\modules\fnc\random\goggles";
			class randomizeGearGoggles{};
			class randomizeGearGogglesInit{};
		};
		class Random_Headgear
		{
			file = "z\mmm\addons\modules\fnc\random\headgear";
			class randomizeGearHeadgear{};
			class randomizeGearHeadgearInit{};
		};
		class Random_Unifroms
		{
			file = "z\mmm\addons\modules\fnc\random\uniforms";
			class randomizeGearUniforms{};
			class randomizeGearUniformsInit{};
		};
		class Random_Vests
		{
			file = "z\mmm\addons\modules\fnc\random\vests";
			class randomizeGearVests{};
			class randomizeGearVestsInit{};
		};
		class Random_Weapons
		{
			file = "z\mmm\addons\modules\fnc\random\weapons";
			class randomizeGearWeapons{};
			class randomizeGearWeaponsInit{};
		};


		class Zenmodule_mmm
		{
			file = "z\mmm\addons\modules\fnc\zenmodule";

			class zenInit{postinit = 1;};
		};
		class Zenmodule_mmm_Main
		{
			file = "z\mmm\addons\modules\fnc\zenmodule\mmm_Main";

			class aceCarryable{};
			class aceDragable{};
			class destroyWithoutExplosion{};
			class removeCrater{};
			class unlimitedAmmoZeus{};
			class unlimitedFuelZeus{};
		};
		class Zenmodule_mmm_AI
		{
			file = "z\mmm\addons\modules\fnc\zenmodule\mmm_AI";
			class stationaryAI{};
			class stationaryGroup{};
		};
		class Zenmodule_mmm_Fun
		{
			file = "z\mmm\addons\modules\fnc\zenmodule\mmm_Fun";

			class zeusHatesArma{};
			class zeusHatesPlayerbase{};
			class warcrimesNotification{};
		};
		class Zenmodule_mmm_Medical
		{
			file = "z\mmm\addons\modules\fnc\zenmodule\mmm_Medical";

			class baseMedicZeus{};
		};
	};
};
