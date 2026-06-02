/*
 * Author: Moony
 * Toggles MMA infection immunity on the unit under the Zeus cursor.
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

if (isNull _objectUnderCursor || {!(_objectUnderCursor isKindOf "CAManBase")}) exitWith {
    [objNull, "PLACE ON A UNIT"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (_objectUnderCursor getVariable ["MMA_main_infectionImmune", false]) exitWith {
    [_objectUnderCursor, false] remoteExec ["MMM_modules_fnc_infectionImmunitySet", 2];
    [objNull, "INFECTION IMMUNITY REMOVED"] call BIS_fnc_showCuratorFeedbackMessage;
};

[
    "Infection Immunity",
    [
        [
            "SLIDER",
            ["Duration", "Duration in seconds if Forever is disabled."],
            [1, 3600, 300, 0]
        ],
        [
            "CHECKBOX",
            ["Forever", "Keep this unit immune until the immunity module is placed on it again."],
            false,
            false
        ]
    ],
    {
        params ["_dialogValues", "_unit"];
        _dialogValues params ["_duration", "_forever"];

        [_unit, true, _duration, _forever] remoteExec ["MMM_modules_fnc_infectionImmunitySet", 2];

        private _text = if (_forever) then {
            "INFECTION IMMUNITY ENABLED"
        } else {
            format ["INFECTION IMMUNITY ENABLED (%1S)", round _duration]
        };
        [objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
    },
    {},
    _objectUnderCursor
] call zen_dialog_fnc_create;
