/*
 * Author: Moony
 * Moves players out of driver and gunner seats after respawning on an MHQ vehicle.
 *
 * Arguments:
 * 0: Respawned player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_unit", objNull, [objNull]]
];

if (!hasInterface || {isNull _unit}) exitWith {};

sleep 0.25;

private _vehicle = vehicle _unit;
if (_vehicle isEqualTo _unit) exitWith {};
if !(_vehicle getVariable [QGVAR(mhqInitialized), false]) exitWith {};

private _crewEntry = (fullCrew [_vehicle, "", true]) select {
    (_x select 0) isEqualTo _unit
};

if (_crewEntry isEqualTo []) exitWith {};

private _role = toLowerANSI ((_crewEntry select 0) select 1);
if !(_role in ["driver", "gunner"]) exitWith {};

moveOut _unit;

private _commanderSeats = (fullCrew [_vehicle, "commander", true]) select {
    isNull (_x select 0)
};

if (_commanderSeats isNotEqualTo []) then {
    _unit moveInCommander _vehicle;
} else {
    _unit moveInCargo _vehicle;
};
