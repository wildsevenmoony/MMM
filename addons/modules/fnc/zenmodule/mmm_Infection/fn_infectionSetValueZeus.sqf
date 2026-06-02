/*
 * Author: Moony
 * Opens a ZEN dialog to set a unit's MMA infection value.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_position", [], [[]]],
    ["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

if !(isNil {_objectUnderCursor getVariable "WBK_AI_ISZombie"}) exitWith {
    [objNull, "ZOMBIES CANNOT BE INFECTED"] call BIS_fnc_showCuratorFeedbackMessage;
};

private _currentValue = _objectUnderCursor getVariable ["MMA_main_infectionLevel", 0];
_currentValue = (_currentValue max 0) min 1;

[
    "Set Infection Value",
    [
        [
            "SLIDER",
            ["Infection Value", "Sets the infection progress from 0 to 1."],
            [0, 1, _currentValue, 2]
        ]
    ],
    {
        params ["_dialogValues", "_unit"];
        _dialogValues params ["_value"];

        _value = (_value max 0) min 1;
        _unit setVariable ["MMA_main_infectionLevel", _value, true];

        if (_value > 0 && {alive _unit} && {!(_unit getVariable ["MMA_main_infected", false])}) then {
            [_unit] remoteExec ["MMA_fnc_infection", _unit];
        };

        [objNull, format ["INFECTION VALUE SET TO %1", _value]] call BIS_fnc_showCuratorFeedbackMessage;
    },
    {},
    _objectUnderCursor
] call zen_dialog_fnc_create;
