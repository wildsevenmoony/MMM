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

private _isExisting = _objectUnderCursor getVariable [QGVAR(mhqInitialized), false];
private _defaultName = if (_isExisting) then {
    _objectUnderCursor getVariable [QGVAR(mhqName), ""]
} else {
    ""
};
private _defaultSide = toLowerANSI (_objectUnderCursor getVariable [QGVAR(mhqSide), "west"]);
private _sideValues = ["west", "east", "independent", "civilian"];
private _sideNames = ["BLUFOR", "OPFOR", "Independent", "Civilian"];
private _defaultSideIndex = _sideValues find _defaultSide;
if (_defaultSideIndex < 0) then {
    _defaultSideIndex = 0;
};
private _defaultAlwaysDeployed = _objectUnderCursor getVariable [QGVAR(mhqAlwaysDeployed), false];
private _defaultStartDeployed = _objectUnderCursor getVariable [QGVAR(mhqDeployed), false];

[
    "Mobile HQ",
    [
        [
            "EDIT",
            ["Respawn Name", "Leave empty for Mobile HQ 1, Mobile HQ 2, ..."],
            _defaultName,
            true
        ],
        [
            "COMBO",
            ["Respawn Side", "Side that receives this MHQ respawn position."],
            [
                _sideValues,
                _sideNames,
                _defaultSideIndex
            ],
            true
        ],
        [
            "CHECKBOX",
            ["Always Deployed", "This MHQ is always deployed, regardless of the global deployment setting."],
            _defaultAlwaysDeployed,
            true
        ],
        [
            "CHECKBOX",
            ["Start Deployed", "Initial deployed state for new MHQs. When editing an existing MHQ, this updates its current deployed state. Ignored when Always Deployed is enabled."],
            _defaultStartDeployed,
            true
        ]
    ],
    {
        params ["_dialogValues", "_objectUnderCursor"];
        _dialogValues params ["_name", "_side", "_alwaysDeployed", "_startDeployed"];

        private _wasExisting = _objectUnderCursor getVariable [QGVAR(mhqInitialized), false];
        [_objectUnderCursor, _side, _name, _alwaysDeployed, _startDeployed] remoteExecCall [QEFUNC(modules,mobileHQSetup), 2];

        private _text = if (_name isEqualTo "") then {
            ["MOBILE HQ CREATED", "MOBILE HQ UPDATED"] select _wasExisting
        } else {
            format ["MOBILE HQ '%1' %2", _name, ["CREATED", "UPDATED"] select _wasExisting]
        };

        [objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
    },
    {},
    _objectUnderCursor,
    format [QGVAR(mobileHQZeus_%1_%2), netId _objectUnderCursor, diag_tickTime]
] call zen_dialog_fnc_create;

[
    _objectUnderCursor,
    _isExisting,
    _defaultName,
    _defaultSide,
    _defaultAlwaysDeployed,
    _defaultStartDeployed
] spawn {
    params ["_target", "_isExisting", "_name", "_side", "_alwaysDeployed", "_startDeployed"];

    private _timeout = diag_tickTime + 2;
    waitUntil {
        sleep 0.01;
        !isNull (uiNamespace getVariable ["zen_common_display", displayNull]) || {diag_tickTime > _timeout}
    };

    if (diag_tickTime > _timeout) exitWith {};

    [_target, _isExisting, _name, _side, _alwaysDeployed, _startDeployed] call EFUNC(modules,mobileHQZeusApplyDefaults);
    [_target, clientOwner] remoteExecCall [QEFUNC(modules,mobileHQZeusRequestDefaults), 2];
};
