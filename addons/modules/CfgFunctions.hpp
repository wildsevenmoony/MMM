class CfgFunctions
{
	class MMM
	{
		class Ai
		{
			file = "\Modules\fnc\ai";
			class stationary_ai_stationary{};
			class stationary_ai_moving{};
			class stationary_ai_init{};
		};
		class Ambient
		{
			file = "\Modules\fnc\ambient";
			class ambientanimationmp{};
			class animation{};
		
		};
		class Medical
		{
			file = "\Modules\fnc\medical";
			class baseMedic{};
			class baseMedicInit{};
		};




		class Zenmodule_MMM
		{
			file = "\Modules\fnc\zenmodule";

			class zenInit{postinit = 1;};
		};
		class Zenmodule_MMM_Main
		{
			file = "\Modules\fnc\zenmodule\MMM_Main";

			class aceCarryable{};
			class aceDragable{};
			class destroyWithoutExplosion{};
			class removeCrater{};
			class unlimitedAmmoZeus{};
			class unlimitedFuelZeus{};
		};
		class Zenmodule_MMM_AI
		{
			file = "\Modules\fnc\zenmodule\MMM_AI";
			class stationaryAI{};
			class stationaryGroup{};
		};
		class Zenmodule_MMM_Fun
		{
			file = "\Modules\fnc\zenmodule\MMM_Fun";

			class zeusHatesArma{};
			class zeusHatesPlayerbase{};
			class warcrimesNotification{};
		};
		class Zenmodule_MMM_Medical
		{
			file = "\Modules\fnc\zenmodule\MMM_Medical";

			class baseMedicZeus{};
		};
	};
};
