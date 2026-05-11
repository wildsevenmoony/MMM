class CfgPatches {
	class mmm_modules {
		name = "Moonys Magnificent Modules - Modules";
		author = "Moony";
		requiredAddons[] = {
			"mmm_main",
            "cba_main",
            "ace_main",
            "ace_common",
            "zen_main",
            "zen_modules"
        };
        units[] = {
			QGVAR(baseMedic),
			QGVAR(spawnWreck),
			QGVAR(ambientAnimationMP),
			QGVAR(animation),
			QGVAR(aiStationary),
			QGVAR(randomizeGearBackpacks),
			QGVAR(randomizeGearGoggles),
			QGVAR(randomizeGearHeadgear),
			QGVAR(randomizeGearUniforms),
			QGVAR(randomizeGearVests),
			QGVAR(randomizeGearWeapons),
			QGVAR(randomizeGear)
			//QGVAR(moduleDialogDemo)
		};
        weapons[] = {};
        requiredVersion = 1.0;
		version = "1.3.0";
	};
};
