class CfgFunctions
{
	class MMM_MODULES
	{
		class Ai
		{
			file = "z\mmm\addons\modules\fnc\ai";
			class stationary_ai_stationary{};
			class stationary_ai_moving{};
			class stationary_ai_init{};
		};
		class Ambient
		{
			file = "z\mmm\addons\modules\fnc\ambient";
			class ambientanimationmp{};
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
			class spawnwreck{};
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
