/*
 * Author: Moony
 * Adds the base medic action to the unit under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_baseMedicZeus
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

private _condition = _objectUnderCursor getVariable [QGVAR(baseMedic), false];

if (_condition) exitWith {[objNull, "UNIT IS ALREADY A BASE MEDIC"] call BIS_fnc_showCuratorFeedbackMessage;};

[_objectUnderCursor] call EFUNC(modules,baseMedic);
[objNull, "BASE MEDIC ADDED"] call BIS_fnc_showCuratorFeedbackMessage;
