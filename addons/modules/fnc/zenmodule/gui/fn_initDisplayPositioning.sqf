#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Sizes the scrollable content area and centers the whole dialog frame.
 *
 * The config uses GUI grid macros for a stable initial layout. This function
 * then converts the frame into final safeZone positions after dynamic controls
 * have been created, which is the part that cannot be known in config.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */

params ["_display"];

private _background = _display displayCtrl IDC_BACKGROUND;
private _title = _display displayCtrl IDC_TITLE;
private _content = _display displayCtrl IDC_MAIN_GROUP;
private _buttonOK = _display displayCtrl IDC_OK;
private _buttonCancel = _display displayCtrl IDC_CANCEL;
private _buttonExport = _display displayCtrl IDC_BUTTON_EXPORT;
private _buttonImport = _display displayCtrl IDC_BUTTON_IMPORT;

if (
    isNull _background
    || {isNull _title}
    || {isNull _content}
    || {isNull _buttonOK}
    || {isNull _buttonCancel}
) exitWith {
    diag_log format ["[MMM] %1: Display frame controls are missing", QEFUNC(modules,initDisplayPositioning)];
};

private _contentHeight = _display getVariable [QGVAR(contentHeight), 0];

// Frame dimensions are kept in GUI-grid units. This keeps the layout visually
// consistent on different aspect ratios while safeZone centering happens here.
private _dialogW = 28 * GUI_GRID_W;
private _titleH = 1 * GUI_GRID_H;
private _paddingX = 0.5 * GUI_GRID_W;
private _gapY = 0.25 * GUI_GRID_H;
private _buttonH = 1 * GUI_GRID_H;
private _buttonW = 5 * GUI_GRID_W;
private _buttonGapTop = 0.5 * GUI_GRID_H;
private _contentBottomPad = 0.5 * GUI_GRID_H;

// Cap the visible content area. If content is taller than this, the controls
// group remains shorter than its children and Arma's vertical scrollbar works.
private _maxContentH = 18 * GUI_GRID_H;
private _minContentH = 4 * GUI_GRID_H;
private _visibleContentH = ((_contentHeight max _minContentH) min _maxContentH);

private _bodyH = _titleH + _gapY + _visibleContentH + _contentBottomPad;
private _dialogH = _bodyH + _buttonGapTop + _buttonH;
private _dialogX = safeZoneX + ((safeZoneW - _dialogW) / 2);
private _dialogY = safeZoneY + ((safeZoneH - _dialogH) / 2);

private _contentX = _dialogX + _paddingX;
private _contentY = _dialogY + _titleH + _gapY;
private _contentW = _dialogW - (2 * _paddingX);
private _buttonY = _dialogY + _bodyH + _buttonGapTop;

// The background frames only the actual dialog body. The buttons sit below it,
// matching the visual layout used by ZEN module dialogs.
_background ctrlSetPosition [_dialogX, _dialogY, _dialogW, _bodyH];
_title ctrlSetPosition [_dialogX, _dialogY, _dialogW, _titleH];
_content ctrlSetPosition [_contentX, _contentY, _contentW, _visibleContentH];
_buttonCancel ctrlSetPosition [_contentX, _buttonY, _buttonW, _buttonH];
_buttonOK ctrlSetPosition [_dialogX + _dialogW - _paddingX - _buttonW, _buttonY, _buttonW, _buttonH];

if (!isNull _buttonExport) then {
    _buttonExport ctrlSetPosition [_contentX + (7 * GUI_GRID_W), _buttonY, _buttonW, _buttonH];
};

if (!isNull _buttonImport) then {
    _buttonImport ctrlSetPosition [_contentX + (14 * GUI_GRID_W), _buttonY, _buttonW, _buttonH];
};

{
    _x ctrlCommit 0;
} forEach ([_background, _title, _content, _buttonCancel, _buttonOK, _buttonExport, _buttonImport] select {!isNull _x});
