/*
 * Author: Moony
 * Compatibility wrapper for the old misspelled ACE draggable function name.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_aceDragable
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

_this call EFUNC(modules,aceDraggable);
