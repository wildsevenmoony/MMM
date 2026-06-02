class MMB_main_RscBaseDisplay;

/*
    MMM keeps only its module-specific display classes here. The reusable frame,
    field collection, import/export, and positioning live in MMB.
*/
class GVAR(RscDisplayExample): MMB_main_RscBaseDisplay {
    onLoad = "(_this select 0) setVariable ['MMB_main_populateFunction', 'mmm_modules_fnc_gui_exampleModule']; call MMB_fnc_initDisplay";
};

class GVAR(RscDisplayRandomizeGear): MMB_main_RscBaseDisplay {
    idd = IDD_RANDOMIZE_GEAR;
    onLoad = "(_this select 0) setVariable ['MMB_main_populateFunction', 'mmm_modules_fnc_gui_randomizeGear']; call MMB_fnc_initDisplay";
};

class GVAR(RscDisplayAceDamage): MMB_main_RscBaseDisplay {
    idd = IDD_ACE_DAMAGE;
    onLoad = "(_this select 0) setVariable ['MMB_main_populateFunction', 'mmm_modules_fnc_gui_aceDamage']; call MMB_fnc_initDisplay";
};
