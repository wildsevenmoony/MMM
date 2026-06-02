#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Opens the ACE damage dialog from a ZEN custom module.
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

uiNamespace setVariable ["MMB_main_pendingDialogArguments", [_objectUnderCursor]];

createDialog QGVAR(RscDisplayAceDamage)
