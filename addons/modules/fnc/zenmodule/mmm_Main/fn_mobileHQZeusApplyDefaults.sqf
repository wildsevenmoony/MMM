/*
 * Author: Moony
 * Applies object-derived Mobile HQ values to an open ZEN Mobile HQ dialog.
 *
 * Arguments:
 * 0: MHQ target object <OBJECT>
 * 1: Existing MHQ <BOOL>
 * 2: Respawn name <STRING>
 * 3: Respawn side <STRING>
 * 4: Always deployed <BOOL>
 * 5: Start/current deployed <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_target", objNull, [objNull]],
    ["_isExisting", false, [false]],
    ["_name", "", [""]],
    ["_side", "west", [""]],
    ["_alwaysDeployed", false, [false]],
    ["_startDeployed", false, [false]]
];

if (!hasInterface || {isNull _target}) exitWith {};

private _display = uiNamespace getVariable ["zen_common_display", displayNull];
if (isNull _display) exitWith {};

private _dialogParams = _display getVariable ["zen_dialog_params", []];
if (_dialogParams isEqualTo []) exitWith {};

_dialogParams params [
    ["_controls", [], [[]]],
    "_onConfirm",
    "_onCancel",
    ["_args", objNull]
];
if (_args isNotEqualTo _target || {count _controls < 4}) exitWith {};

private _sideValues = ["west", "east", "independent", "civilian"];
private _sideIndex = _sideValues find toLowerANSI _side;
if (_sideIndex < 0) then {
    _sideIndex = 0;
};

private _nameControl = ((_controls select 0) select 0) controlsGroupCtrl 1004;
private _sideControl = ((_controls select 1) select 0) controlsGroupCtrl 1003;
private _alwaysControl = ((_controls select 2) select 0) controlsGroupCtrl 1002;
private _startControl = ((_controls select 3) select 0) controlsGroupCtrl 1002;

if (isNull _nameControl || {isNull _sideControl} || {isNull _alwaysControl} || {isNull _startControl}) exitWith {};

_nameControl ctrlSetText ([_name, ""] select !_isExisting);
_sideControl lbSetCurSel _sideIndex;
_alwaysControl cbSetChecked _alwaysDeployed;
_startControl cbSetChecked _startDeployed;
