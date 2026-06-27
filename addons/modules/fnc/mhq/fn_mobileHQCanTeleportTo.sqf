/*
 * Author: Moony
 * Checks whether a player may currently teleport to an MHQ destination.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Destination MHQ <OBJECT>
 * 2: Return reason when blocked <BOOL>
 *
 * Return Value:
 * Can teleport <BOOL> or [can teleport, reason] <ARRAY>
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_player", objNull, [objNull]],
    ["_destination", objNull, [objNull]],
    ["_withReason", false, [false]]
];

private _reason = "";
private _canTeleport = true;

if (isNull _player || {isNull _destination}) then {
    _canTeleport = false;
    _reason = "Invalid MHQ destination.";
};

if (_canTeleport && {!alive _player || {!alive _destination}}) then {
    _canTeleport = false;
    _reason = "The MHQ is no longer available.";
};

if (_canTeleport && {!(_destination getVariable [QGVAR(mhqDeployed), false])}) then {
    _canTeleport = false;
    _reason = "The MHQ is not deployed.";
};

if (_canTeleport && {[_destination] call EFUNC(modules,mobileHQIsMoving)}) then {
    _canTeleport = false;
    _reason = "The MHQ is currently moving.";
};

if (_canTeleport && {_destination isKindOf "CAManBase"}) then {
    private _radius = missionNamespace getVariable [QGVAR(mhqEnemyRadius), 150];
    if (_radius > 0) then {
        private _side = side group _destination;
        private _enemyIndex = allUnits findIf {
            alive _x
            && {_x distance _destination <= _radius}
            && {side group _x getFriend _side < 0.6}
        };
        if (_enemyIndex >= 0) then {
            _canTeleport = false;
            _reason = "Known enemies are close to the MHQ unit.";
        };
    };
};

if (_withReason) exitWith {[_canTeleport, _reason]};
_canTeleport
