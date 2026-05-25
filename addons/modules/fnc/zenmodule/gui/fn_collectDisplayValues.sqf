#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Collects values from all dynamic input controls registered by a dialog
 * populate function.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Collected values in the form [label, idc, type, value] <ARRAY>
 */

params ["_display"];

private _fields = _display getVariable [QGVAR(fields), []];
private _values = [];

{
    _x params ["_label", "_idc", "_type"];

    private _control = _display displayCtrl _idc;
    if (isNull _control) then {
        diag_log format ["[MMM] %1: Missing registered field '%2' with IDC %3", QEFUNC(modules,collectDisplayValues), _label, _idc];
    } else {
        private _value = switch (_type) do {
            case "edit": {
                ctrlText _control
            };
            case "checkbox": {
                cbChecked _control
            };
            case "slider": {
                (round ((sliderPosition _control) * 100)) / 100
            };
            case "combo": {
                private _index = lbCurSel _control;
                if (_index < 0) then {
                    ""
                } else {
                    _control lbData _index
                }
            };
            default {
                diag_log format ["[MMM] %1: Unknown field type '%2' for '%3'", QEFUNC(modules,collectDisplayValues), _type, _label];
                nil
            };
        };

        _values pushBack [_label, _idc, _type, _value];
    };
} forEach _fields;

_values
