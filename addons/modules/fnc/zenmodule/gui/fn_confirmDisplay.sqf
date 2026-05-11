#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Generic OK handler for reusable dynamic dialogs.
 *
 * It collects all registered field values, calls the module-specific confirm
 * function stored on the display, and closes the dialog unless that function
 * explicitly returns false.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Dialog should close <BOOL>
 */

params ["_display"];

private _values = [_display] call EFUNC(modules,collectDisplayValues);
private _onConfirm = _display getVariable [QGVAR(onConfirm), ""];
private _arguments = _display getVariable [QGVAR(arguments), []];
private _saveKey = _display getVariable [QGVAR(saveKey), ""];
private _shouldClose = true;

if (_saveKey != "") then {
    profileNamespace setVariable [_saveKey, _values];
    saveProfileNamespace;
};

if (_onConfirm != "") then {
    private _function = missionNamespace getVariable [_onConfirm, {}];
    private _result = [_display, _values, _arguments] call _function;

    // Returning false from a module-specific confirm function keeps the dialog
    // open, which is useful for validation errors.
    if (_result isEqualType false) then {
        _shouldClose = _result;
    };
};

if (_shouldClose) then {
    closeDialog 1;
};

_shouldClose
