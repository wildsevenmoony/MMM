#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Exports the current dynamic dialog values to the clipboard.
 *
 * The format is intentionally text-editor friendly:
 * - Lines beginning with // are ignored by import.
 * - Each value line is KEY = VALUE.
 * - Strings are exported quoted via str, so commas in classname lists are safe.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Export text <STRING>
 */

params ["_display"];

private _values = [_display] call EFUNC(modules,collectDisplayValues);
private _lineBreak = toString [13, 10];
private _lines = [
    "MMM_DIALOG_EXPORT_V1",
    "// Edit values on KEY = VALUE lines. Lines starting with // are ignored.",
    "// Strings should stay quoted. Checkboxes use true/false. Sliders use numbers."
];

{
    _x params ["_key", "_idc", "_type", "_value"];

    private _valueText = if (_value isEqualType "") then {
        str _value
    } else {
        str _value
    };

    _lines pushBack format ["%1 = %2", _key, _valueText];
} forEach _values;

private _text = _lines joinString _lineBreak;
copyToClipboard _text;

[objNull, "DIALOG VALUES EXPORTED TO CLIPBOARD"] call BIS_fnc_showCuratorFeedbackMessage;

_text
