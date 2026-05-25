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
 * _xField         Field column x position <NUMBER>
 * _rowWLabel      Label column width <NUMBER>
 * _rowWField      Field column width <NUMBER>
 * _rowH           Normal row height <NUMBER>
 * _categoryH      Category row height <NUMBER>
 * _rowGap         Gap after a normal row <NUMBER>
 * _categoryGapTop Gap before categories after the first one <NUMBER>
 * _savedValues     Previously collected values, or [] if unused <ARRAY>
 * _y              Current content y position <NUMBER>
 *
 * _rowBackgroundX Row background x position <NUMBER>
 * _categoryBodyX  Light category body x position <NUMBER>
 * _categoryBodyW  Light category body width <NUMBER>
 * _sectionPadY    Top and bottom padding inside category bodies <NUMBER>
 * _columnGapW     Gap between label bar and value control <NUMBER>
 * _sliderEditW    Width of the number edit next to sliders <NUMBER>
 * _sliderGapW     Gap between slider and number edit <NUMBER>
 * _toggleGapW     Gap between No/Yes toggle buttons <NUMBER>
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

private _addRowBackground = {
    private _backgroundX = [_rowBackgroundX, _categoryBodyX] select (isNull _activeCategoryBody);
    private _labelTextX = _backgroundX + (0.25 * GUI_GRID_W);
    private _backgroundW = (_xField - _columnGapW - _backgroundX) max GUI_GRID_W;
    private _backgroundColor = if (isNull _activeCategoryBody) then {
        [0, 0, 0, 0.35]
    } else {
        [0, 0, 0, 0.5]
    };

    // Each action is split into a dark label bar and a separate value control.
    // The light category body, when present, stays visible in the gap between.
    private _background = ["RscText", -1, [_backgroundX, _y, _backgroundW, _rowH], ""] call _addControl;
    _background ctrlSetBackgroundColor _backgroundColor;

    [_labelTextX, _xField]
};

private _applyTooltip = {
    params ["_control", "_tooltip"];

    if (_tooltip isNotEqualTo "") then {
        _control ctrlSetTooltip _tooltip;
    };
};

private _activeCategoryBody = controlNull;
private _activeCategoryBodyY = 0;

private _finalizeCategoryBody = {
    if (!isNull _activeCategoryBody) then {
        // The body starts directly under the category header and stretches
        // behind all rows in that category, including the last row's padding.
        _activeCategoryBody ctrlSetPosition [
            _categoryBodyX,
            _activeCategoryBodyY,
            _categoryBodyW,
            (_y - _activeCategoryBodyY) max _sectionPadY
        ];
        _activeCategoryBody ctrlCommit 0;
        _activeCategoryBody = controlNull;
    };
};

private _formatSliderValue = {
    params ["_value"];

    // Keep slider edits readable: max two decimal places, but whole numbers
    // stay clean, e.g. 1 instead of 1.00.
    str ((round (_value * 100)) / 100)
};

private _setToggleVisuals = {
    params ["_checkbox", "_buttonNo", "_buttonYes", "_checked"];

    _checkbox cbSetChecked _checked;

    private _activeColor = [
        profileNamespace getVariable ["GUI_BCG_RGB_R", 0.13],
        profileNamespace getVariable ["GUI_BCG_RGB_G", 0.54],
        profileNamespace getVariable ["GUI_BCG_RGB_B", 0.21],
        profileNamespace getVariable ["GUI_BCG_RGB_A", 0.8]
    ];

    if (_checked) then {
        _buttonNo ctrlSetBackgroundColor [0, 0, 0, 0.45];
        _buttonYes ctrlSetBackgroundColor _activeColor;
    } else {
        _buttonNo ctrlSetBackgroundColor _activeColor;
        _buttonYes ctrlSetBackgroundColor [0, 0, 0, 0.45];
    };
};

private _addCategory = {
    params ["_text", "_idc"];

    call _finalizeCategoryBody;

    if (_y > _contentPaddingY) then {
        _y = _y + _categoryGapTop;
    };

    private _control = ["RscText", _idc, [_categoryBodyX, _y, _categoryBodyW, _categoryH], _text] call _addControl;
    _control ctrlSetBackgroundColor [0, 0, 0, 0.35];
    _control ctrlSetText format ["   %1", _text];
    _y = _y + _categoryH;

    _activeCategoryBodyY = _y;
    _activeCategoryBody = ["RscText", -1, [_categoryBodyX, _activeCategoryBodyY, _categoryBodyW, 0], ""] call _addControl;
    _activeCategoryBody ctrlSetBackgroundColor [0.34, 0.34, 0.34, 0.35];
    _y = _y + _sectionPadY;
};

private _addEdit = {
    params ["_label", "_labelIdc", "_editIdc", ["_default", ""], ["_key", ""], ["_tooltip", ""]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _default = (_savedValues select _index) select 3;
        };
    };

    (call _addRowBackground) params ["_labelTextX", "_fieldX"];
    private _labelControl = ["RscText", _labelIdc, [_labelTextX, _y, _rowWLabel, _rowH], _label] call _addControl;
    [_labelControl, _tooltip] call _applyTooltip;
    private _edit = ["RscEdit", _editIdc, [_fieldX, _y, _rowWField, _rowH], _default] call _addControl;
    _fields pushBack [_key, _editIdc, "edit"];
    _y = _y + _rowH + _rowGap;

    _edit
};

private _addCheckbox = {
    params ["_label", "_labelIdc", "_checkboxIdc", ["_checked", false], ["_key", ""], ["_tooltip", ""]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _checked = (_savedValues select _index) select 3;
        };
    };

    private _toggleGapWActual = _toggleGapW;
    private _buttonW = (_rowWField - _toggleGapWActual) / 2;

    (call _addRowBackground) params ["_labelTextX", "_fieldX"];
    private _labelControl = ["RscText", _labelIdc, [_labelTextX, _y, _rowWLabel, _rowH], _label] call _addControl;
    [_labelControl, _tooltip] call _applyTooltip;

    // Keep a real checkbox as the stored value control, but present the user
    // with a ZEN-like two-choice toggle. This preserves the existing boolean
    // collection/import/export path.
    private _checkbox = ["RscCheckBox", _checkboxIdc, [0, _y, 0, 0]] call _addControl;
    private _buttonNo = ["RscButton", -1, [_fieldX, _y, _buttonW, _rowH], "No"] call _addControl;
    private _buttonYes = ["RscButton", -1, [_fieldX + _buttonW + _toggleGapWActual, _y, _buttonW, _rowH], "Yes"] call _addControl;

    [_checkbox, _buttonNo, _buttonYes, _checked] call _setToggleVisuals;

    _buttonNo setVariable [QGVAR(toggleControls), [_checkbox, _buttonNo, _buttonYes]];
    _buttonYes setVariable [QGVAR(toggleControls), [_checkbox, _buttonNo, _buttonYes]];

    _buttonNo ctrlAddEventHandler ["ButtonClick", {
        params ["_buttonNo"];

        (_buttonNo getVariable [QGVAR(toggleControls), [controlNull, controlNull, controlNull]]) params ["_checkbox", "_buttonNoStored", "_buttonYes"];
        if (!isNull _checkbox && {!isNull _buttonYes}) then {
            [_checkbox, _buttonNo, _buttonYes, false] call (_checkbox getVariable QGVAR(setToggleVisuals));
        };
    }];

    _buttonYes ctrlAddEventHandler ["ButtonClick", {
        params ["_buttonYes"];

        (_buttonYes getVariable [QGVAR(toggleControls), [controlNull, controlNull, controlNull]]) params ["_checkbox", "_buttonNo", "_buttonYesStored"];
        if (!isNull _checkbox && {!isNull _buttonNo}) then {
            [_checkbox, _buttonNo, _buttonYes, true] call (_checkbox getVariable QGVAR(setToggleVisuals));
        };
    }];

    _checkbox setVariable [QGVAR(setToggleVisuals), _setToggleVisuals];
    _checkbox setVariable [QGVAR(toggleControls), [_buttonNo, _buttonYes]];
    _fields pushBack [_key, _checkboxIdc, "checkbox"];
    _y = _y + _rowH + _rowGap;

    _checkbox
};

private _addSlider = {
    params ["_label", "_labelIdc", "_sliderIdc", ["_range", [0, 100]], ["_default", 50], ["_key", ""], ["_speed", [1, 10]], ["_tooltip", ""]];

    if (_key isEqualTo "") then {
        _key = _label;
    };

    if !(isNil "_savedValues") then {
        private _index = _savedValues findIf {(_x select 0) isEqualTo _key};
        if (_index != -1) then {
            _default = (_savedValues select _index) select 3;
        };
    };

    private _sliderEditWActual = _sliderEditW;
    private _sliderGapWActual = _sliderGapW;
    private _sliderW = _rowWField - _sliderEditWActual - _sliderGapWActual;

    (call _addRowBackground) params ["_labelTextX", "_fieldX"];
    private _labelControl = ["RscText", _labelIdc, [_labelTextX, _y, _rowWLabel, _rowH], _label] call _addControl;
    [_labelControl, _tooltip] call _applyTooltip;
    private _slider = [QGVAR(RscXSliderH), _sliderIdc, [_fieldX, _y, _sliderW, _rowH]] call _addControl;
    private _valueEdit = ["RscEdit", -1, [_fieldX + _sliderW + _sliderGapWActual, _y, _sliderEditWActual, _rowH], [_default] call _formatSliderValue] call _addControl;
    _slider sliderSetRange _range;
    _slider sliderSetSpeed _speed;
    _slider sliderSetPosition _default;
    _slider setVariable [QGVAR(valueEdit), _valueEdit];
    _slider setVariable [QGVAR(sliderRange), _range];
    _slider setVariable [QGVAR(formatSliderValue), _formatSliderValue];
    _valueEdit setVariable [QGVAR(valueSlider), _slider];

    _slider ctrlAddEventHandler ["SliderPosChanged", {
        params ["_slider", "_value"];

        private _valueEdit = _slider getVariable [QGVAR(valueEdit), controlNull];
        if (!isNull _valueEdit) then {
            private _formatSliderValue = _slider getVariable QGVAR(formatSliderValue);
            _valueEdit ctrlSetText ([_value] call _formatSliderValue);
        };
    }];

    _valueEdit ctrlAddEventHandler ["KeyUp", {
        params ["_valueEdit"];

        private _slider = _valueEdit getVariable [QGVAR(valueSlider), controlNull];
        if (!isNull _slider) then {
            private _range = _slider getVariable [QGVAR(sliderRange), [0, 100]];
            private _value = parseNumber ctrlText _valueEdit;
            _value = (_value max (_range select 0)) min (_range select 1);
            _value = (round (_value * 100)) / 100;
            _slider sliderSetPosition _value;
        };
    }];

    _valueEdit ctrlAddEventHandler ["KillFocus", {
        params ["_valueEdit"];

        private _slider = _valueEdit getVariable [QGVAR(valueSlider), controlNull];
        if (!isNull _slider) then {
            private _range = _slider getVariable [QGVAR(sliderRange), [0, 100]];
            private _value = parseNumber ctrlText _valueEdit;
            _value = (_value max (_range select 0)) min (_range select 1);
            _value = (round (_value * 100)) / 100;
            _slider sliderSetPosition _value;
            private _formatSliderValue = _slider getVariable QGVAR(formatSliderValue);
            _valueEdit ctrlSetText ([_value] call _formatSliderValue);
        };
    }];

    _fields pushBack [_key, _sliderIdc, "slider"];
    _y = _y + _rowH + _rowGap;

    _slider
};
