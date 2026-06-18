/*
 * Author: Moony
 * Maintains the dynamic MHQ respawn point.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]]
];

if (!isServer || {isNull _mhq}) exitWith {};

while {!isNull _mhq && {alive _mhq}} do {
    [_mhq] call EFUNC(modules,mobileHQApplyFeatures);

    private _active = _mhq getVariable [QGVAR(mhqRespawnActive), false];
    private _canRespawn = [_mhq] call EFUNC(modules,mobileHQCanRespawn);

    if (_canRespawn && {!_active}) then {
        private _side = call compile (_mhq getVariable [QGVAR(mhqSide), "west"]);
        private _name = _mhq getVariable [QGVAR(mhqName), "Mobile HQ"];
        private _handle = [_side, _mhq, _name] call BIS_fnc_addRespawnPosition;

        _mhq setVariable [QGVAR(mhqRespawnHandle), _handle, true];
        _mhq setVariable [QGVAR(mhqRespawnActive), true, true];
    };

    if (!_canRespawn && _active) then {
        private _handle = _mhq getVariable [QGVAR(mhqRespawnHandle), []];

        if (_handle isNotEqualTo []) then {
            _handle call BIS_fnc_removeRespawnPosition;
        };

        _mhq setVariable [QGVAR(mhqRespawnHandle), [], true];
        _mhq setVariable [QGVAR(mhqRespawnActive), false, true];
    };

    sleep 5;
};

private _handle = _mhq getVariable [QGVAR(mhqRespawnHandle), []];

if (_handle isNotEqualTo []) then {
    _handle call BIS_fnc_removeRespawnPosition;
};

if (_mhq getVariable [QGVAR(mhqArsenalActive), false]) then {
    if !(isNil "ace_arsenal_fnc_removeBox") then {
        [_mhq] call ace_arsenal_fnc_removeBox;
    };
};

_mhq setVariable [QGVAR(mhqDeployed), false, true];
_mhq setVariable [QGVAR(mhqRespawnHandle), [], true];
_mhq setVariable [QGVAR(mhqRespawnActive), false, true];
_mhq setVariable [QGVAR(mhqArsenalActive), false, true];

private _mhqs = missionNamespace getVariable [QGVAR(mhqs), []];
private _index = _mhqs find _mhq;
if (_index >= 0) then {
    _mhqs deleteAt _index;
};
missionNamespace setVariable [QGVAR(mhqs), _mhqs, true];
