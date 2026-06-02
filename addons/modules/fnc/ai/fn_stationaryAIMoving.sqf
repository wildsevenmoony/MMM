/*
 * Author: Moony
 * Enables AI pathing and clears the stationary marker on the unit.
 *
 * Arguments:
 * 0: AI <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [someAI] call mmm_modules_fnc_stationaryAIMoving
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {};

[_unit, "PATH"] remoteExec ["enableAI", 0, true];
_unit setVariable [QGVAR(aiStationary), false, true];

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
    diag_log format ["[%1] Stationary AI disabled for %2", QADDON, _unit];
};

// Only restore WBK civilian behaviour when stationary mode disabled it earlier.
private _wbkCivisLoaded = ["WBK_Civies"] call ace_common_fnc_isModLoaded;
if (_wbkCivisLoaded) then {
    private _checkIfDisabled = _unit getVariable [QGVAR(wbkCivBehaviourWasDisabled), true];
    if (!_checkIfDisabled) then {
        _unit setVariable ["WBK_DisableCivBehaviour", false, true];
        _unit setVariable [QGVAR(wbkCivBehaviourWasDisabled), nil, true];
        if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
            diag_log format ["[%1] Restored WBK civilian behaviour for %2", QADDON, _unit];
        };
    };
};
