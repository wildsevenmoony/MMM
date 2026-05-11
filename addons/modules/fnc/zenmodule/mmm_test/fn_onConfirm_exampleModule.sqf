#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Demo confirm function for the dynamic dialog example.
 *
 * This is where a real Zeus module would execute its behavior after the user
 * presses OK. The reusable GUI code has already collected the control values.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Values as [label, idc, type, value] <ARRAY>
 * 2: Extra arguments stored on the display <ARRAY>
 *
 * Return Value:
 * Close dialog <BOOL>
 */

params ["_display", "_values", "_arguments"];

private _lines = _values apply {
    _x params ["_label", "_idc", "_type", "_value"];

    format ["%1 (%2): %3", _label, _type, _value]
};

private _message = _lines joinString "\n";

diag_log format ["[MMM] Example dialog confirmed:%1%2", endl, _message];
hint format ["Example dialog values:\n%1", _message];

true
