/*
 * Author: Moony
 * Initializes the Mobile HQ module on synced editor objects.
 *
 * Arguments:
 * 0: Logic object <OBJECT>
 * 1: Synced objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_logic", objNull, [objNull]],
    ["_objects", [], [[]]]
];

if (!isServer) exitWith {};

private _side = _logic getVariable [QGVAR(mobileHQSide), "west"];
private _name = _logic getVariable [QGVAR(mobileHQName), ""];
private _alwaysDeployed = _logic getVariable [QGVAR(mobileHQAlwaysDeployed), false];

{
    [_x, _side, _name, _alwaysDeployed] call EFUNC(modules,mobileHQSetup);
} forEach (_objects select {!isNull _x});
