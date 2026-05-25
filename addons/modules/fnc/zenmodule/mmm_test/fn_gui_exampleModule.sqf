#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Creates all example module controls dynamically inside a RscControlsGroup.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Content controls group <CONTROL>
 *
 * Return Value:
 * None
 */

params ["_display", "_content"];

private _controls = [];
private _fields = [];

private _contentPaddingY = 0.45 * GUI_GRID_H;
private _xField = 12.5 * GUI_GRID_W;
private _rowWLabel = 11 * GUI_GRID_W;
private _rowWField = 13.5 * GUI_GRID_W;
private _categoryBodyX = 0.35 * GUI_GRID_W;
private _categoryBodyW = 26.9 * GUI_GRID_W;
private _rowBackgroundX = 1.55 * GUI_GRID_W;
private _columnGapW = 0.16 * GUI_GRID_W;
private _sliderEditW = 2.3 * GUI_GRID_W;
private _sliderGapW = 0.25 * GUI_GRID_W;
private _toggleGapW = 0;
private _sectionPadY = 0.16 * GUI_GRID_H;
private _rowH = 1 * GUI_GRID_H;
private _categoryH = 1 * GUI_GRID_H;
private _rowGap = 0.16 * GUI_GRID_H;
private _categoryGapTop = 0.32 * GUI_GRID_H;
private _saveKey = QGVAR(randomizeGearDialogValues);
private _savedValues = profileNamespace getVariable [_saveKey, []];
private _y = _contentPaddingY;

// Adds _addCategory, _addEdit, _addCheckbox, and _addSlider helper closures.
#include "\z\mmm\addons\modules\fnc\zenmodule\gui\script_guiHelpers.hpp"

["Category Label 1", IDC_CATEGORY1_TEXT] call _addCategory;
["Label 1.1", IDC_LABEL_1_1, IDC_EDIT_1_1] call _addEdit;
["Label 1.2", IDC_LABEL_1_2, IDC_SLIDER_1_2, [0, 100], 50] call _addSlider;

["Category Label 2", IDC_CATEGORY2_TEXT] call _addCategory;
["Label 2.1", IDC_LABEL_2_1, IDC_CHECK_2_1] call _addCheckbox;
["Label 2.2", IDC_LABEL_2_2, IDC_EDIT_2_2] call _addEdit;
["Label 2.3", IDC_LABEL_2_3, IDC_CHECK_2_3] call _addCheckbox;

["Label 3", IDC_LABEL_3, IDC_EDIT_3] call _addEdit;
["Label 4", IDC_LABEL_4, IDC_EDIT_4] call _addEdit;

["Category Label 4", IDC_CATEGORY4_TEXT] call _addCategory;
["Label 4.1", IDC_LABEL_4_1, IDC_CHECK_4_1] call _addCheckbox;
["Label 4.2", IDC_LABEL_4_2, IDC_EDIT_4_2] call _addEdit;
["Label 4.3", IDC_LABEL_4_3, IDC_CHECK_4_3] call _addCheckbox;

["Category Label 5", IDC_CATEGORY5_TEXT] call _addCategory;
["Label 5.1", IDC_LABEL_5_1, IDC_CHECK_5_1] call _addCheckbox;
["Label 5.2", IDC_LABEL_5_2, IDC_EDIT_5_2] call _addEdit;
["Label 5.3", IDC_LABEL_5_3, IDC_CHECK_5_3] call _addCheckbox;

call _finalizeCategoryBody;

// This tells the reusable OK handler which module-specific function should run
// after it has collected the field values.
_display setVariable [QGVAR(onConfirm), QEFUNC(modules,onConfirm_exampleModule)];
_display setVariable [QGVAR(saveKey), _saveKey];
_display setVariable [QGVAR(importExportEnabled), true];

_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(fields), _fields];
_display setVariable [QGVAR(contentHeight), _y + _contentPaddingY];
