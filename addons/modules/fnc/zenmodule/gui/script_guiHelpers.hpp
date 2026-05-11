/*
 * Author: Moony
 * Reusable helper closures for dynamic dialog content.
 *
 * Include this file inside a dialog populate function after defining the local
 * layout state listed below. The helpers intentionally use local variables, so
 * this is an include file instead of a normal SQF function.
 *
 * Required local variables:
 * _display        Display that owns the controls <DISPLAY>
 * _content        RscControlsGroup that receives the dynamic controls <CONTROL>
 * _controls       Array where every created control is stored <ARRAY>
 * _fields         Array where input controls are registered <ARRAY>
 * _xLabel         Label column x position <NUMBER>
 * _xField         Field column x position <NUMBER>
 * _rowWLabel      Label column width <NUMBER>
 * _rowWField      Field column width <NUMBER>
 * _categoryW      Category label width <NUMBER>
 * _rowH           Normal row height <NUMBER>
 * _categoryH      Category row height <NUMBER>
 * _rowGap         Gap after a normal row <NUMBER>
 * _categoryGapTop Gap before categories after the first one <NUMBER>
 * _categoryGapBottom Gap after category rows <NUMBER>
 * _savedValues     Previously collected values, or [] if unused <ARRAY>
 * _y              Current content y position <NUMBER>
 */

private _addControl = {
    params ["_class", "_idc", "_position", ["_text", ""]];

    // Dynamic children for a controls group are created from the display and
    // receive the group as the third argument.
    private _control = _display ctrlCreate [_class, _idc, _content];
    _control ctrlSetPosition _position;

    if (_text != "") then {
        _control ctrlSetText _text;
    };

    _control ctrlCommit 0;
    _controls pushBack _control;

    _control
};

private _addCategory = {
    params ["_text", "_idc"];

    if (_y > 0) then {
        _y = _y + _categoryGapTop;
    };

    private _control = ["RscText", _idc, [_xLabel, _y, _categoryW, _categoryH], _text] call _addControl;
    _control ctrlSetBackgroundColor [0, 0, 0, 0.35];
    _y = _y + _categoryH + _categoryGapBottom;
};

private _addEdit = {
    params ["_label", "_labelIdc", "_editIdc", ["_default", ""], ["_key", ""]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _default = (_savedValues select _index) select 3;
        };
    };

    ["RscText", _labelIdc, [_xLabel, _y, _rowWLabel, _rowH], _label] call _addControl;
    private _edit = ["RscEdit", _editIdc, [_xField, _y, _rowWField, _rowH], _default] call _addControl;
    _fields pushBack [_key, _editIdc, "edit"];
    _y = _y + _rowH + _rowGap;

    _edit
};

private _addCheckbox = {
    params ["_label", "_labelIdc", "_checkboxIdc", ["_checked", false], ["_key", ""]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _checked = (_savedValues select _index) select 3;
        };
    };

    ["RscText", _labelIdc, [_xLabel, _y, _rowWLabel, _rowH], _label] call _addControl;
    private _checkbox = ["RscCheckBox", _checkboxIdc, [_xField, _y, _rowH, _rowH]] call _addControl;
    _checkbox cbSetChecked _checked;
    _fields pushBack [_key, _checkboxIdc, "checkbox"];
    _y = _y + _rowH + _rowGap;

    _checkbox
};

private _addSlider = {
    params ["_label", "_labelIdc", "_sliderIdc", ["_range", [0, 100]], ["_default", 50], ["_key", ""], ["_speed", [1, 10]]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _default = (_savedValues select _index) select 3;
        };
    };

    ["RscText", _labelIdc, [_xLabel, _y, _rowWLabel, _rowH], _label] call _addControl;
    private _slider = [QGVAR(RscXSliderH), _sliderIdc, [_xField, _y, _rowWField, _rowH]] call _addControl;
    _slider sliderSetRange _range;
    _slider sliderSetSpeed _speed;
    _slider sliderSetPosition _default;
    _fields pushBack [_key, _sliderIdc, "slider"];
    _y = _y + _rowH + _rowGap;

    _slider
};
