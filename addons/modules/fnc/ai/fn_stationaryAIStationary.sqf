/*
 * Author: Moony
 * Disables AI pathing and marks the unit as stationary.
 *
 * Arguments:
 * 0: AI <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [someAI] call mmm_modules_fnc_stationaryAIStationary
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {};

[_unit, "PATH"] remoteExec ["disableAI", 0, true];
_unit setVariable [QGVAR(aiStationary), true, true];

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
    diag_log format ["[%1] Stationary AI enabled for %2", QADDON, _unit];
};

// WBK civilians can re-enable movement; remember whether this function changed it.
private _wbkCivisLoaded = ["WBK_Civies"] call ace_common_fnc_isModLoaded;
if (_wbkCivisLoaded && {missionNamespace getVariable [QGVAR(stationaryAIDisableWBKCivBehaviour), true]}) then {
    private _checkIfDisabled = _unit getVariable ["WBK_DisableCivBehaviour", false];
    if (!_checkIfDisabled) then {
        _unit setVariable [QGVAR(wbkCivBehaviourWasDisabled), false, true];
        _unit setVariable ["WBK_DisableCivBehaviour", true, true];
        if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
            diag_log format ["[%1] Disabled WBK civilian behaviour for stationary unit %2", QADDON, _unit];
        };
    };
};
