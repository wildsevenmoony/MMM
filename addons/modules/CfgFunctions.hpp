class CfgFunctions
{
	class mmm_modules
	{
		class Ai
		{
			file = PATHTOF(fnc\ai);
			class stationaryAIStationary{};
			class stationaryAIMoving{};
			class stationaryAIInit{};
		};
		class Ambient
		{
			file = PATHTOF(fnc\ambient);
			class applyAmbientAnimation{};
			class applyPlayMoveAnimation{};
			class applySwitchMoveAnimation{};
			class ambientAnimationMP{};
			class animation{};
			class parseCustomAnimation{};
			class playMoveAnimation{};
			class previewAnimation3DEN{};
			class refreshAnimationPreview3DEN{};
		};
		class Medical
		{
			file = PATHTOF(fnc\medical);
			class baseMedic{};
			class baseMedicInit{};
		};
		class Misc
		{
			file = PATHTOF(fnc\misc);
			class spawnWreck{};
		};
		class Random_Backpacks
		{
			file = PATHTOF(fnc\random\backpacks);
			class randomizeGearBackpacks{};
			class randomizeGearBackpacksInit{};
		};
		class Random_Full
		{
			file = PATHTOF(fnc\random\full);
			class randomizeGearInit{};
		};
		class Random_Goggles
		{
			file = PATHTOF(fnc\random\goggles);
			class randomizeGearGoggles{};
			class randomizeGearGogglesInit{};
		};
		class Random_Headgear
		{
			file = PATHTOF(fnc\random\headgear);
			class randomizeGearHeadgear{};
			class randomizeGearHeadgearInit{};
		};
		class Random_Uniforms
		{
			file = PATHTOF(fnc\random\uniforms);
			class randomizeGearUniforms{};
			class randomizeGearUniformsInit{};
		};
		class Random_Vests
		{
			file = PATHTOF(fnc\random\vests);
			class randomizeGearVests{};
			class randomizeGearVestsInit{};
		};
		class Random_Weapons
		{
			file = PATHTOF(fnc\random\weapons);
			class randomizeGearWeapons{};
			class randomizeGearWeaponsInit{};
		};
		class Zenmodule_mmm
		{
			file = PATHTOF(fnc\zenmodule);

			class zenInit{postinit = 1;};
		};
		class Zenmodule_mmm_GUI
		{
			file = PATHTOF(fnc\zenmodule\gui);

			class collectDisplayValues{};
			class confirmDisplay{};
			class exportDisplayValues{};
			class importDisplayValues{};
			class initDisplay{};
			class initDisplayPositioning{};
		};
		class Zenmodule_mmm_Test
		{
			file = PATHTOF(fnc\zenmodule\mmm_test);

			class gui_exampleModule{};
			class moduleExample{};
			class onConfirm_exampleModule{};
		};
		class Zenmodule_mmm_Main
		{
			file = PATHTOF(fnc\zenmodule\mmm_Main);

			class aceCarryable{};
			class aceDragable{};
			class destroyWithoutExplosion{};
			class respawnTimer{};
			class removeCrater{};
			class unlimitedAmmoZeus{};
			class unlimitedFuelZeus{};
		};
		class Zenmodule_mmm_AI
		{
			file = PATHTOF(fnc\zenmodule\mmm_AI);
			class stationaryAI{};
			class stationaryGroup{};
		};
		class Zenmodule_mmm_Fun
		{
			file = PATHTOF(fnc\zenmodule\mmm_Fun);

			class zeusHatesArma{};
			class zeusHatesPlayerbase{};
			class warcrimesNotification{};
		};
		class Zenmodule_mmm_Medical
		{
			file = PATHTOF(fnc\zenmodule\mmm_Medical);

			class baseMedicZeus{};
		};
		class Zenmodule_mmm_Random
		{
			file = PATHTOF(fnc\zenmodule\mmm_Random);
			
			class gui_randomizeGear{};
			class onConfirm_randomizeGear{};
			class randomizeGearZeus{};
			class randomizeGearBackpacksGroupZeus{};
			class randomizeGearGogglesGroupZeus{};
			class randomizeGearHeadgearGroupZeus{};
			class randomizeGearUniformsGroupZeus{};
			class randomizeGearVestsGroupZeus{};
			class randomizeGearWeaponsGroupZeus{};
		};
	};
};
