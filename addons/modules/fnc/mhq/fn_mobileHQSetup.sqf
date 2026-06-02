/*
 * Author: Moony
 * Marks an object as an MHQ and starts its server-side feature monitor.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 * 1: Respawn side <STRING>
 * 2: Respawn name <STRING>
 * 3: Always deployed <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player] call mmm_modules_fnc_mobileHQSetup
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]],
    ["_side", "west", [""]],
    ["_name", "", [""]],
    ["_alwaysDeployed", false, [false]]
];

if (!isServer || {isNull _mhq}) exitWith {};

private _initialized = _mhq getVariable [QGVAR(mhqInitialized), false];
private _index = missionNamespace getVariable [QGVAR(mhqCount), 0];

if (!_initialized) then {
    _index = _index + 1;
    missionNamespace setVariable [QGVAR(mhqCount), _index, true];
};

if (isNil "_name" || {!(_name isEqualType "")}) then {
    _name = "";
};

if (_name isEqualTo "") then {
    _name = _mhq getVariable [QGVAR(mhqName), "Mobile HQ"];
};

private _sideNormalized = toLowerANSI _side;
private _mhqs = missionNamespace getVariable [QGVAR(mhqs), []];
private _usedNames = _mhqs apply {
    if (
        !isNull _x
        && {alive _x}
        && {_x isNotEqualTo _mhq}
        && {(_x getVariable [QGVAR(mhqSide), "west"]) isEqualTo _sideNormalized}
    ) then {
        _x getVariable [QGVAR(mhqName), ""]
    } else {
        ""
    };
};

private _baseName = _name;
private _suffix = 2;
while {_name in _usedNames} do {
    _name = format ["%1 %2", _baseName, _suffix];
    _suffix = _suffix + 1;
};

_mhq setVariable [QGVAR(mhqInitialized), true, true];
_mhq setVariable [QGVAR(mhqSide), _sideNormalized, true];
_mhq setVariable [QGVAR(mhqName), _name, true];
_mhq setVariable [QGVAR(mhqAlwaysDeployed), _alwaysDeployed, true];

private _deployed = if (_alwaysDeployed) then {
    true
} else {
    if (_initialized) then {
        _mhq getVariable [QGVAR(mhqDeployed), false]
    } else {
        !(missionNamespace getVariable [QGVAR(mhqEnableDeployment), true])
    };
};

_mhq setVariable [QGVAR(mhqDeployed), _deployed, true];

private _handle = _mhq getVariable [QGVAR(mhqRespawnHandle), []];
if (_handle isNotEqualTo []) then {
    _handle call BIS_fnc_removeRespawnPosition;
};

_mhq setVariable [QGVAR(mhqRespawnHandle), [], true];
_mhq setVariable [QGVAR(mhqRespawnActive), false, true];

if (!_initialized) then {
    _mhqs pushBackUnique _mhq;
    missionNamespace setVariable [QGVAR(mhqs), _mhqs, true];

    _mhq setVariable [QGVAR(mhqArsenalActive), false, true];
    [_mhq] remoteExecCall [QEFUNC(modules,mobileHQAddActions), 0, true];
    [_mhq] spawn EFUNC(modules,mobileHQMonitor);
};

[_mhq] call EFUNC(modules,mobileHQApplyFeatures);

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
    diag_log format ["[%1] Mobile HQ initialized on %2 as '%3' for %4", QADDON, _mhq, _name, _side];
};
