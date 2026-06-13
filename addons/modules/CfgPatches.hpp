class CfgPatches {
	class mmm_modules {
		name = "Moony's Magnificent Modules - Modules";
		author = "Moony";
		requiredAddons[] = {
			"mmb_main",
			"mmm_main",
			"A3_Modules_F",
            "cba_main",
            "cba_settings",
            "ace_main",
            "ace_common",
            "ace_interact_menu",
            "ace_medical",
            "ace_medical_treatment",
            "3DEN",
            "zen_main",
            "zen_modules"
        };
		units[] = {
			QGVAR(aceDamage),
			QGVAR(aiStationary),
			QGVAR(ambientAnimationMP),
			QGVAR(animation),
			QGVAR(aceArsenal),
			QGVAR(playMoveAnimation),
			QGVAR(mobileHQ),
			QGVAR(baseMedic),
			QGVAR(randomizeGear),
			QGVAR(randomizeGearBackpacks),
			QGVAR(randomizeGearGoggles),
			QGVAR(randomizeGearHeadgear),
			QGVAR(randomizeGearUniforms),
			QGVAR(randomizeGearVests),
			QGVAR(randomizeGearWeapons),
			QGVAR(spawnWreck)
			//QGVAR(moduleDialogDemo)
		};
        weapons[] = {};
        requiredVersion = 1.56;
		version = "1.3.0";
	};
};
