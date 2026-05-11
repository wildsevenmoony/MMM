#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Initializes a dynamic Zeus-module dialog.
 *
 * This follows the same conceptual flow ZEN uses:
 * display opens -> initDisplay -> module populate function -> positioning.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */

params ["_display"];

uiNamespace setVariable [QGVAR(displayExample), _display];

private _pendingArguments = uiNamespace getVariable [QGVAR(pendingDialogArguments), []];
uiNamespace setVariable [QGVAR(pendingDialogArguments), nil];
_display setVariable [QGVAR(arguments), _pendingArguments];

private _content = _display displayCtrl IDC_MAIN_GROUP;
if (isNull _content) exitWith {
    diag_log format ["[MMM] %1: Missing content control IDC %2", QEFUNC(modules,initDisplay), IDC_MAIN_GROUP];
};

// These arrays are intentionally maintained by us. Arma has no ctrlControls
// command, so dynamic controls must be tracked explicitly if we need them later.
_display setVariable [QGVAR(controls), []];
_display setVariable [QGVAR(fields), []];
_display setVariable [QGVAR(contentHeight), 0];
_display setVariable [QGVAR(onConfirm), ""];
_display setVariable [QGVAR(importExportEnabled), false];

// The display class sets QGVAR(populateFunction) before calling this function.
// If it does not, we fall back to the example module.
private _populateFunctionName = _display getVariable [QGVAR(populateFunction), QEFUNC(modules,gui_exampleModule)];
private _populateFunction = missionNamespace getVariable [_populateFunctionName, {}];
[_display, _content] call _populateFunction;

private _buttonOK = _display displayCtrl IDC_OK;
private _buttonExport = _display displayCtrl IDC_BUTTON_EXPORT;
private _buttonImport = _display displayCtrl IDC_BUTTON_IMPORT;
if (!isNull _buttonOK) then {
    // The handler runs before the dialog closes, so text/checkbox/slider values
    // are still available. The generic confirm function then calls the
    // module-specific function stored by the populate function.
    _buttonOK ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        [ctrlParent _control] call EFUNC(modules,confirmDisplay);
    }];
};

private _importExportEnabled = _display getVariable [QGVAR(importExportEnabled), false];

{
    if (!isNull _x) then {
        _x ctrlShow _importExportEnabled;
        _x ctrlEnable _importExportEnabled;
    };
} forEach [_buttonExport, _buttonImport];

if (!isNull _buttonExport) then {
    _buttonExport ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        [ctrlParent _control] call EFUNC(modules,exportDisplayValues);
    }];
};

if (!isNull _buttonImport) then {
    _buttonImport ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        [ctrlParent _control] call EFUNC(modules,importDisplayValues);
    }];
};

// Center and resize the complete frame after content exists.
[_display] call EFUNC(modules,initDisplayPositioning);
