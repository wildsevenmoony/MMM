#include "script_component.hpp"

/*
 * Author: Moony
 * Registers CBA settings for configurable module defaults and diagnostics.
 */

if (isNil "cba_settings_fnc_init") exitWith {};

[QGVAR(debugLogging), "CHECKBOX",
    ["Debug logging", "Writes useful MMM module events to the RPT log."],
    ["Moony's Magnificent Modules", "00 Debug"],
    false, 1
] call cba_settings_fnc_init;

[QGVAR(baseMedicActionDistance), "SLIDER",
    ["Base medic action distance", "Maximum distance in meters for base medic heal actions."],
    ["Moony's Magnificent Modules", "Base Medic"],
    [1, 10, 3, 1], 1
] call cba_settings_fnc_init;

[QGVAR(baseMedicHealRadius), "SLIDER",
    ["Base medic group heal radius", "Radius in meters healed by the base medic area heal action."],
    ["Moony's Magnificent Modules", "Base Medic"],
    [1, 50, 10, 0], 1
] call cba_settings_fnc_init;

[QGVAR(stationaryAIDisableWBKCivBehaviour), "CHECKBOX",
    ["Stationary AI disables WBK civilian behaviour", "Lets the stationary AI module temporarily disable WBK Civies behaviour so civilians stay put."],
    ["Moony's Magnificent Modules", "AI"],
    true, 1
] call cba_settings_fnc_init;

[QGVAR(respawnTimerDefault), "SLIDER",
    ["Respawn timer default", "Default value shown in the Zeus respawn timer dialog."],
    ["Moony's Magnificent Modules", "Zeus"],
    [1, 600, 120, 0], 1
] call cba_settings_fnc_init;

[QGVAR(respawnTimerMax), "SLIDER",
    ["Respawn timer maximum", "Maximum value shown in the Zeus respawn timer dialog."],
    ["Moony's Magnificent Modules", "Zeus"],
    [1, 3600, 300, 0], 1
] call cba_settings_fnc_init;

[QGVAR(mhqEnableDeployment), "CHECKBOX",
    ["Enable deployment", "Requires MHQs to be deployed before respawn, arsenal, and base medic features become available."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    true, 1
] call cba_settings_fnc_init;

[QGVAR(mhqRespawnEnabled), "CHECKBOX",
    ["Enable respawn point", "Adds a mobile respawn point to deployed MHQs."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    true, 1
] call cba_settings_fnc_init;

[QGVAR(mhqEnemyRadius), "SLIDER",
    ["Enemy block radius", "Respawn is disabled while enemies are within this radius of a deployed MHQ."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    [0, 1000, 150, 0], 1
] call cba_settings_fnc_init;

[QGVAR(mhqArsenalEnabled), "CHECKBOX",
    ["Enable ACE Arsenal", "Adds an ACE Arsenal to deployed MHQs when ACE Arsenal is loaded."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    false, 1
] call cba_settings_fnc_init;

[QGVAR(mhqArsenalItems), "EDITBOX",
    ["ACE Arsenal items", "Comma-separated item classnames. Quotes are optional. Leave empty for a full ACE Arsenal."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    "", 1
] call cba_settings_fnc_init;

[QGVAR(mhqBaseMedicEnabled), "CHECKBOX",
    ["Enable base medic", "Adds MMM base medic actions to deployed MHQs."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    false, 1
] call cba_settings_fnc_init;

[QGVAR(mhqDeployDuration), "SLIDER",
    ["Deploy duration", "ACE progress duration in seconds for deploying or undeploying an MHQ. Set to 0 for instant."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    [0, 120, 5, 1], 1
] call cba_settings_fnc_init;

[QGVAR(mhqTeleportEnabled), "CHECKBOX",
    ["Enable MHQ teleport", "Adds an ACE interaction for teleporting between deployed MHQs on the player's side."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    false, 1
] call cba_settings_fnc_init;

[QGVAR(mhqTeleportIncludeFriendlySides), "CHECKBOX",
    ["Include friendly MHQs", "Allows teleporting to deployed MHQs from sides currently friendly to the player's side."],
    ["Moony's Magnificent Modules", "Mobile HQ"],
    false, 1
] call cba_settings_fnc_init;
