/*
 * Author: Moony
 * Applies or removes MMA infection immunity on a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Immune <BOOL>
 * 2: Duration in seconds <NUMBER>
 * 3: Forever <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_immune", true, [true]],
    ["_duration", 300, [0]],
    ["_forever", false, [true]]
];

if (!isServer || {isNull _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {};

if (!_immune) exitWith {
    _unit setVariable ["MMA_main_infectionImmune", false, true];
    _unit setVariable ["MMA_main_infectionSuppressionUntil", nil, true];
    _unit setVariable [QGVAR(infectionImmunityToken), nil, true];
};

private _token = diag_tickTime;
_unit setVariable ["MMA_main_infectionImmune", true, true];
_unit setVariable [QGVAR(infectionImmunityToken), _token, true];

if (_forever) then {
    _unit setVariable ["MMA_main_infectionSuppressionUntil", -1, true];
} else {
    private _endTime = CBA_missionTime + (_duration max 1);
    _unit setVariable ["MMA_main_infectionSuppressionUntil", _endTime, true];

    [_unit, _endTime, _token] spawn {
        params ["_unit", "_endTime", "_token"];

        waitUntil {
            sleep 1;
            isNull _unit
                || {!alive _unit}
                || {CBA_missionTime >= _endTime}
                || {(_unit getVariable [QGVAR(infectionImmunityToken), -1]) isNotEqualTo _token}
        };

        if (
            !isNull _unit
            && {alive _unit}
            && {(_unit getVariable [QGVAR(infectionImmunityToken), -1]) isEqualTo _token}
        ) then {
            _unit setVariable ["MMA_main_infectionImmune", false, true];
            _unit setVariable ["MMA_main_infectionSuppressionUntil", nil, true];
            _unit setVariable [QGVAR(infectionImmunityToken), nil, true];
        };
    };
};
