class CfgPatches {
	class mmm_modules {
		name = "Moonys Magnificent Modules - Modules";
		author = "Moony";
		requiredAddons[] = {
			"mmm_main",
            "cba_main",
            "ace_main",
            "ace_common",
            "3DEN",
            "zen_main",
            "zen_modules"
        };
		units[] = {
			QGVAR(aceDamage),
			QGVAR(aiStationary),
			QGVAR(ambientAnimationMP),
			QGVAR(animation),
			QGVAR(playMoveAnimation),
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
        requiredVersion = 1.0;
		version = "1.3.0";
	};
};
