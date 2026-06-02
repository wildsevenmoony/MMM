/*
 * Author: Moony
 * Checks whether an MHQ should currently expose its respawn position.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 *
 * Return Value:
 * Respawn is available <BOOL>
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]]
];

if (isNull _mhq || {!alive _mhq}) exitWith {false};
if !(missionNamespace getVariable [QGVAR(mhqRespawnEnabled), true]) exitWith {false};
if !(_mhq getVariable [QGVAR(mhqDeployed), false]) exitWith {false};

private _radius = missionNamespace getVariable [QGVAR(mhqEnemyRadius), 150];
if (_radius <= 0) exitWith {true};

private _side = call compile (_mhq getVariable [QGVAR(mhqSide), "west"]);
private _enemies = allUnits findIf {
    alive _x
    && {_x distance _mhq <= _radius}
    && {side _x getFriend _side < 0.6}
};

_enemies isEqualTo -1
