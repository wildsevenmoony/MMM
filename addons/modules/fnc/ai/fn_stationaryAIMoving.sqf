/*
 * Author: Moony
 * Enables AIs Pathing capabilities and gives a status variable to the unit
 *
 * Arguments:
 * 0: AI <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [someAI] call mmm_modules_fnc_stationaryAIMoving.sqf
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params ["_unit"];

[_unit, "PATH"] remoteExec ["enableAI", 0, true];
_unit setVariable [QGVAR(aiStationary), false, true];
