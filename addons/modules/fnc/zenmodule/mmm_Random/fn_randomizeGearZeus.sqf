#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Opens the full gear randomization dialog from a ZEN custom module.
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * Dialog created <BOOL>
 */

params ["_position", "_objectUnderCursor"];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

// fn_initDisplay.sqf reads this once and stores it on the display. This keeps
// the selected Zeus target available when OK is pressed later.
uiNamespace setVariable ["MMB_main_pendingDialogArguments", [_objectUnderCursor]];

createDialog QGVAR(RscDisplayRandomizeGear)
