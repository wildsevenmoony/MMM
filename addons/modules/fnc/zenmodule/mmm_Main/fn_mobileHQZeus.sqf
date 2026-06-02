/*
 * Author: Moony
 * Marks the object under the Zeus cursor as a Mobile HQ.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_mobileHQZeus
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_position", [], [[]]],
    ["_objectUnderCursor", objNull, [objNull]]
];

if (isNull _objectUnderCursor) exitWith {};

[
    "Mobile HQ",
    [
        [
            "EDIT",
            ["Respawn Name", "Leave empty for Mobile HQ 1, Mobile HQ 2, ..."],
            "",
            false
        ],
        [
            "COMBO",
            ["Respawn Side", "Side that receives this MHQ respawn position."],
            [
                ["west", "east", "independent", "civilian"],
                ["BLUFOR", "OPFOR", "Independent", "Civilian"],
                0
            ],
            false
        ],
        [
            "CHECKBOX",
            ["Always Deployed", "This MHQ is always deployed, regardless of the global deployment setting."],
            false,
            false
        ]
    ],
    {
        params ["_dialogValues", "_objectUnderCursor"];
        _dialogValues params ["_name", "_side", "_alwaysDeployed"];

        [_objectUnderCursor, _side, _name, _alwaysDeployed] remoteExecCall [QEFUNC(modules,mobileHQSetup), 2];

        private _text = if (_name isEqualTo "") then {
            "MOBILE HQ CREATED"
        } else {
            format ["MOBILE HQ '%1' CREATED", _name]
        };

        [objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
    },
    {},
    _objectUnderCursor
] call zen_dialog_fnc_create;
