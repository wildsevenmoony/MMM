#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Opens the standalone dynamic dialog demo.
 *
 * This function is intentionally tiny: all actual UI setup lives in the
 * display onLoad flow. That keeps the same dialog usable from the debug
 * console, a ZEN custom module, or a regular Curator module.
 *
 * Arguments:
 * ZEN custom module:
 * 0: Position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Vanilla Curator module:
 * 0: Module logic <OBJECT>
 * 1: Synced units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * Dialog created <BOOL>
 */

if (!hasInterface) exitWith {};

createDialog QGVAR(RscDisplayExample);
