/*
 * Author: Moony
 * Sets an MHQ deployed state and refreshes dependent features.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 * 1: Deployed <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]],
    ["_deployed", false, [false]]
];

if (!isServer || {isNull _mhq}) exitWith {};
if (_mhq getVariable [QGVAR(mhqAlwaysDeployed), false]) exitWith {
    _mhq setVariable [QGVAR(mhqDeployed), true, true];
    [_mhq] call EFUNC(modules,mobileHQApplyFeatures);
};

_mhq setVariable [QGVAR(mhqDeployed), _deployed, true];
[_mhq] call EFUNC(modules,mobileHQApplyFeatures);
