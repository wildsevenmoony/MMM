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

// Checking if WBKs Simple Civilian Behaivour is already disabled on that unit
_wbkCivisLoaded = ["WBK_Civies"] call ace_common_fnc_isModLoaded;
if (_wbkCivisLoaded) then {
    _checkIfDisabled = _unit getVariable [QGVAR(WBK_DisableCivBehaviourDisableCheck), true];
    if (!_checkIfDisabled) then {
        _unit setVariable ["WBK_DisableCivBehaviour",false]; 
    };
};
