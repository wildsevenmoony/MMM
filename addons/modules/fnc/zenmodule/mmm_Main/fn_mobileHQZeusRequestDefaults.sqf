/*
 * Author: Moony
 * Sends the server-authoritative Mobile HQ values for a target object back to a Zeus client.
 *
 * Arguments:
 * 0: MHQ target object <OBJECT>
 * 1: Client owner ID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_target", objNull, [objNull]],
    ["_clientOwner", 0, [0]]
];

if (!isServer || {isNull _target} || {_clientOwner <= 0}) exitWith {};

private _isExisting = _target getVariable [QGVAR(mhqInitialized), false];
private _name = if (_isExisting) then {
    _target getVariable [QGVAR(mhqName), ""]
} else {
    ""
};
private _side = _target getVariable [QGVAR(mhqSide), "west"];
private _alwaysDeployed = _target getVariable [QGVAR(mhqAlwaysDeployed), false];
private _startDeployed = _target getVariable [QGVAR(mhqDeployed), false];

[_target, _isExisting, _name, _side, _alwaysDeployed, _startDeployed] remoteExecCall [QEFUNC(modules,mobileHQZeusApplyDefaults), _clientOwner];
