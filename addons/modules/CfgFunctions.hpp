class CfgFunctions
{
	class mmm_modules
	{
		class Ambient
		{
			file = PATHTOF(fnc\ambient);
			class ambientAnimationMP{};
			class animation{};
			class applyAmbientAnimation{};
			class applyPlayMoveAnimation{};
			class applySwitchMoveAnimation{};
			class parseCustomAnimation{};
			class playMoveAnimation{};
			class previewAnimation3DEN{};
			class refreshAnimationPreview3DEN{};
		};
		class Ai
		{
			file = PATHTOF(fnc\ai);
			class stationaryAIInit{};
			class stationaryAIMoving{};
			class stationaryAIStationary{};
		};
		class Medical
		{
			file = PATHTOF(fnc\medical);
			class aceDamage{};
			class aceDamageInit{};
			class aceDamageLocal{};
			class baseMedic{};
			class baseMedicInit{};
		};
		class MHQ
		{
			file = PATHTOF(fnc\mhq);
			class mobileHQAddActions{};
			class mobileHQApplyFeatures{};
			class mobileHQCanRespawn{};
			class mobileHQHandleRespawn{};
			class mobileHQInit{};
			class mobileHQMonitor{};
			class mobileHQParseArsenalItems{};
			class mobileHQSetDeployed{};
			class mobileHQSetup{};
			class mobileHQTeleport{};
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
			class aceDraggable{};
			class destroyWithoutExplosion{};
			class mobileHQZeus{};
			class removeCrater{};
			class respawnTimer{};
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

			class warcrimesNotification{};
			class zeusHatesArma{};
			class zeusHatesPlayerbase{};
		};
		class Zenmodule_mmm_Infection
		{
			file = PATHTOF(fnc\zenmodule\mmm_Infection);

			class infectionCureZeus{};
			class infectionImmunitySet{};
			class infectionImmunityZeus{};
			class infectionInfectZeus{};
			class infectionKillInfectedZeus{};
			class infectionSetValueZeus{};
			class toxicAreaZeus{};
		};
		class Zenmodule_mmm_Medical
		{
			file = PATHTOF(fnc\zenmodule\mmm_Medical);

			class aceDamageZeus{};
			class baseMedicZeus{};
			class gui_aceDamage{};
			class onConfirm_aceDamage{};
		};
		class Zenmodule_mmm_Random
		{
			file = PATHTOF(fnc\zenmodule\mmm_Random);
			
			class gui_randomizeGear{};
			class onConfirm_randomizeGear{};
			class randomizeGearBackpacksGroupZeus{};
			class randomizeGearGogglesGroupZeus{};
			class randomizeGearHeadgearGroupZeus{};
			class randomizeGearUniformsGroupZeus{};
			class randomizeGearVestsGroupZeus{};
			class randomizeGearWeaponsGroupZeus{};
			class randomizeGearZeus{};
		};
	};
};
