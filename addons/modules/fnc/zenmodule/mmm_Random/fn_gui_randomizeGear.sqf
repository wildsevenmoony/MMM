#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Builds the full gear randomization dialog.
 *
 * This dialog combines the single equipment randomizers into one scrollable
 * interface. It only creates controls and stores metadata; execution happens in
 * fn_onConfirm_randomizeGear.sqf after the reusable OK handler collects values.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Content controls group <CONTROL>
 *
 * Return Value:
 * None
 */

params ["_display", "_content"];

private _title = _display displayCtrl IDC_TITLE;
if (!isNull _title) then {
    _title ctrlSetText "Full Gear Randomization";
};

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
private _chanceRange = [0, 1];
private _chanceSpeed = [0.01, 0.1];
private _saveKey = QGVAR(randomizeGearDialogValues);
private _savedValues = profileNamespace getVariable [_saveKey, []];
private _y = _contentPaddingY;

#include "\z\mmm\addons\modules\fnc\zenmodule\gui\script_guiHelpers.hpp"

private _addEquipmentBlock = {
    params [
        "_title",
        "_prefix",
        "_categoryIdc",
        "_randomLabelIdc",
        "_randomControlIdc",
        "_forceLabelIdc",
        "_forceControlIdc",
        "_chanceLabelIdc",
        "_chanceControlIdc",
        "_contentLabelIdc",
        "_contentControlIdc",
        "_contentHint"
    ];

    [_title, _categoryIdc] call _addCategory;
    ["Randomization", _randomLabelIdc, _randomControlIdc, false, format ["%1Random", _prefix], format ["Enable randomizing %1 for the selected unit.", toLowerANSI _title]] call _addCheckbox;
    ["Force adding", _forceLabelIdc, _forceControlIdc, false, format ["%1Force", _prefix], format ["Add the new %1 even when the unit already has one.", toLowerANSI _title]] call _addCheckbox;
    ["Empty chance", _chanceLabelIdc, _chanceControlIdc, _chanceRange, 0, format ["%1Chance", _prefix], _chanceSpeed, "Chance from 0 to 1 that this equipment slot is left empty."] call _addSlider;
    [_contentHint, _contentLabelIdc, _contentControlIdc, "", format ["%1Content", _prefix], "Comma-separated classnames to choose from. Leave empty to use the module defaults."] call _addEdit;
};

private _addWeaponBlock = {
    params [
        "_title",
        "_prefix",
        "_categoryIdc",
        "_randomLabelIdc",
        "_randomControlIdc",
        "_forceLabelIdc",
        "_forceControlIdc",
        "_contentLabelIdc",
        "_contentControlIdc",
        "_scopeRandomLabelIdc",
        "_scopeRandomControlIdc",
        "_scopeChanceLabelIdc",
        "_scopeChanceControlIdc",
        "_scopeContentLabelIdc",
        "_scopeContentControlIdc",
        "_railRandomLabelIdc",
        "_railRandomControlIdc",
        "_railChanceLabelIdc",
        "_railChanceControlIdc",
        "_railContentLabelIdc",
        "_railContentControlIdc",
        "_muzzleRandomLabelIdc",
        "_muzzleRandomControlIdc",
        "_muzzleChanceLabelIdc",
        "_muzzleChanceControlIdc",
        "_muzzleContentLabelIdc",
        "_muzzleContentControlIdc",
        "_bipodRandomLabelIdc",
        "_bipodRandomControlIdc",
        "_bipodChanceLabelIdc",
        "_bipodChanceControlIdc",
        "_bipodContentLabelIdc",
        "_bipodContentControlIdc",
        "_weaponHint"
    ];

    [_title, _categoryIdc] call _addCategory;
    ["Randomization", _randomLabelIdc, _randomControlIdc, false, format ["%1Random", _prefix], format ["Enable randomizing the %1 slot.", toLowerANSI _title]] call _addCheckbox;
    ["Force adding", _forceLabelIdc, _forceControlIdc, false, format ["%1Force", _prefix], "Add the weapon even when the unit already has a weapon in this slot."] call _addCheckbox;
    [_weaponHint, _contentLabelIdc, _contentControlIdc, "", format ["%1Content", _prefix], "Comma-separated weapon classnames to choose from. Leave empty to use the module defaults."] call _addEdit;

    ["Scope randomization", _scopeRandomLabelIdc, _scopeRandomControlIdc, false, format ["%1ScopeRandom", _prefix], "Enable randomizing optic attachments for this weapon."] call _addCheckbox;
    ["Scope empty chance", _scopeChanceLabelIdc, _scopeChanceControlIdc, _chanceRange, 0, format ["%1ScopeChance", _prefix], _chanceSpeed, "Chance from 0 to 1 that no optic is added."] call _addSlider;
    ["Scope classnames", _scopeContentLabelIdc, _scopeContentControlIdc, "", format ["%1ScopeContent", _prefix], "Comma-separated optic classnames to choose from."] call _addEdit;

    ["Rail randomization", _railRandomLabelIdc, _railRandomControlIdc, false, format ["%1RailRandom", _prefix], "Enable randomizing rail attachments for this weapon."] call _addCheckbox;
    ["Rail empty chance", _railChanceLabelIdc, _railChanceControlIdc, _chanceRange, 0, format ["%1RailChance", _prefix], _chanceSpeed, "Chance from 0 to 1 that no rail attachment is added."] call _addSlider;
    ["Rail classnames", _railContentLabelIdc, _railContentControlIdc, "", format ["%1RailContent", _prefix], "Comma-separated rail attachment classnames to choose from."] call _addEdit;

    ["Muzzle randomization", _muzzleRandomLabelIdc, _muzzleRandomControlIdc, false, format ["%1MuzzleRandom", _prefix], "Enable randomizing muzzle attachments for this weapon."] call _addCheckbox;
    ["Muzzle empty chance", _muzzleChanceLabelIdc, _muzzleChanceControlIdc, _chanceRange, 0, format ["%1MuzzleChance", _prefix], _chanceSpeed, "Chance from 0 to 1 that no muzzle attachment is added."] call _addSlider;
    ["Muzzle classnames", _muzzleContentLabelIdc, _muzzleContentControlIdc, "", format ["%1MuzzleContent", _prefix], "Comma-separated muzzle attachment classnames to choose from."] call _addEdit;

    ["Bipod randomization", _bipodRandomLabelIdc, _bipodRandomControlIdc, false, format ["%1BipodRandom", _prefix], "Enable randomizing bipod attachments for this weapon."] call _addCheckbox;
    ["Bipod empty chance", _bipodChanceLabelIdc, _bipodChanceControlIdc, _chanceRange, 0, format ["%1BipodChance", _prefix], _chanceSpeed, "Chance from 0 to 1 that no bipod is added."] call _addSlider;
    ["Bipod classnames", _bipodContentLabelIdc, _bipodContentControlIdc, "", format ["%1BipodContent", _prefix], "Comma-separated bipod classnames to choose from."] call _addEdit;
};

["Apply to group", IDC_RANDOMIZE_GROUP_LABEL, IDC_RANDOMIZE_GROUP_CHECK, false, "Group", "Apply the selected randomization settings to the whole selected group instead of only one unit."] call _addCheckbox;

[
    "Backpacks", "Backpacks",
    IDC_RANDOMIZE_BACKPACKS_CATEGORY,
    IDC_RANDOMIZE_BACKPACKS_RANDOM_LABEL, IDC_RANDOMIZE_BACKPACKS_RANDOM_CHECK,
    IDC_RANDOMIZE_BACKPACKS_FORCE_LABEL, IDC_RANDOMIZE_BACKPACKS_FORCE_CHECK,
    IDC_RANDOMIZE_BACKPACKS_CHANCE_LABEL, IDC_RANDOMIZE_BACKPACKS_CHANCE_SLIDER,
    IDC_RANDOMIZE_BACKPACKS_CONTENT_LABEL, IDC_RANDOMIZE_BACKPACKS_CONTENT_EDIT,
    "Backpack classnames"
] call _addEquipmentBlock;

[
    "Goggles", "Goggles",
    IDC_RANDOMIZE_GOGGLES_CATEGORY,
    IDC_RANDOMIZE_GOGGLES_RANDOM_LABEL, IDC_RANDOMIZE_GOGGLES_RANDOM_CHECK,
    IDC_RANDOMIZE_GOGGLES_FORCE_LABEL, IDC_RANDOMIZE_GOGGLES_FORCE_CHECK,
    IDC_RANDOMIZE_GOGGLES_CHANCE_LABEL, IDC_RANDOMIZE_GOGGLES_CHANCE_SLIDER,
    IDC_RANDOMIZE_GOGGLES_CONTENT_LABEL, IDC_RANDOMIZE_GOGGLES_CONTENT_EDIT,
    "Goggle classnames"
] call _addEquipmentBlock;

[
    "Headgear", "Headgear",
    IDC_RANDOMIZE_HEADGEAR_CATEGORY,
    IDC_RANDOMIZE_HEADGEAR_RANDOM_LABEL, IDC_RANDOMIZE_HEADGEAR_RANDOM_CHECK,
    IDC_RANDOMIZE_HEADGEAR_FORCE_LABEL, IDC_RANDOMIZE_HEADGEAR_FORCE_CHECK,
    IDC_RANDOMIZE_HEADGEAR_CHANCE_LABEL, IDC_RANDOMIZE_HEADGEAR_CHANCE_SLIDER,
    IDC_RANDOMIZE_HEADGEAR_CONTENT_LABEL, IDC_RANDOMIZE_HEADGEAR_CONTENT_EDIT,
    "Headgear classnames"
] call _addEquipmentBlock;

[
    "Uniforms", "Uniforms",
    IDC_RANDOMIZE_UNIFORMS_CATEGORY,
    IDC_RANDOMIZE_UNIFORMS_RANDOM_LABEL, IDC_RANDOMIZE_UNIFORMS_RANDOM_CHECK,
    IDC_RANDOMIZE_UNIFORMS_FORCE_LABEL, IDC_RANDOMIZE_UNIFORMS_FORCE_CHECK,
    IDC_RANDOMIZE_UNIFORMS_CHANCE_LABEL, IDC_RANDOMIZE_UNIFORMS_CHANCE_SLIDER,
    IDC_RANDOMIZE_UNIFORMS_CONTENT_LABEL, IDC_RANDOMIZE_UNIFORMS_CONTENT_EDIT,
    "Uniform classnames"
] call _addEquipmentBlock;

[
    "Vests", "Vests",
    IDC_RANDOMIZE_VESTS_CATEGORY,
    IDC_RANDOMIZE_VESTS_RANDOM_LABEL, IDC_RANDOMIZE_VESTS_RANDOM_CHECK,
    IDC_RANDOMIZE_VESTS_FORCE_LABEL, IDC_RANDOMIZE_VESTS_FORCE_CHECK,
    IDC_RANDOMIZE_VESTS_CHANCE_LABEL, IDC_RANDOMIZE_VESTS_CHANCE_SLIDER,
    IDC_RANDOMIZE_VESTS_CONTENT_LABEL, IDC_RANDOMIZE_VESTS_CONTENT_EDIT,
    "Vest classnames"
] call _addEquipmentBlock;

[
    "Primary weapon", "Primary",
    IDC_RANDOMIZE_PRIMARY_CATEGORY,
    IDC_RANDOMIZE_PRIMARY_RANDOM_LABEL, IDC_RANDOMIZE_PRIMARY_RANDOM_CHECK,
    IDC_RANDOMIZE_PRIMARY_FORCE_LABEL, IDC_RANDOMIZE_PRIMARY_FORCE_CHECK,
    IDC_RANDOMIZE_PRIMARY_CONTENT_LABEL, IDC_RANDOMIZE_PRIMARY_CONTENT_EDIT,
    IDC_RANDOMIZE_PRIMARY_SCOPE_RANDOM_LABEL, IDC_RANDOMIZE_PRIMARY_SCOPE_RANDOM_CHECK,
    IDC_RANDOMIZE_PRIMARY_SCOPE_CHANCE_LABEL, IDC_RANDOMIZE_PRIMARY_SCOPE_CHANCE_SLIDER,
    IDC_RANDOMIZE_PRIMARY_SCOPE_CONTENT_LABEL, IDC_RANDOMIZE_PRIMARY_SCOPE_CONTENT_EDIT,
    IDC_RANDOMIZE_PRIMARY_RAIL_RANDOM_LABEL, IDC_RANDOMIZE_PRIMARY_RAIL_RANDOM_CHECK,
    IDC_RANDOMIZE_PRIMARY_RAIL_CHANCE_LABEL, IDC_RANDOMIZE_PRIMARY_RAIL_CHANCE_SLIDER,
    IDC_RANDOMIZE_PRIMARY_RAIL_CONTENT_LABEL, IDC_RANDOMIZE_PRIMARY_RAIL_CONTENT_EDIT,
    IDC_RANDOMIZE_PRIMARY_MUZZLE_RANDOM_LABEL, IDC_RANDOMIZE_PRIMARY_MUZZLE_RANDOM_CHECK,
    IDC_RANDOMIZE_PRIMARY_MUZZLE_CHANCE_LABEL, IDC_RANDOMIZE_PRIMARY_MUZZLE_CHANCE_SLIDER,
    IDC_RANDOMIZE_PRIMARY_MUZZLE_CONTENT_LABEL, IDC_RANDOMIZE_PRIMARY_MUZZLE_CONTENT_EDIT,
    IDC_RANDOMIZE_PRIMARY_BIPOD_RANDOM_LABEL, IDC_RANDOMIZE_PRIMARY_BIPOD_RANDOM_CHECK,
    IDC_RANDOMIZE_PRIMARY_BIPOD_CHANCE_LABEL, IDC_RANDOMIZE_PRIMARY_BIPOD_CHANCE_SLIDER,
    IDC_RANDOMIZE_PRIMARY_BIPOD_CONTENT_LABEL, IDC_RANDOMIZE_PRIMARY_BIPOD_CONTENT_EDIT,
    "Primary weapon classnames"
] call _addWeaponBlock;

[
    "Sidearm", "Sidearm",
    IDC_RANDOMIZE_SIDEARM_CATEGORY,
    IDC_RANDOMIZE_SIDEARM_RANDOM_LABEL, IDC_RANDOMIZE_SIDEARM_RANDOM_CHECK,
    IDC_RANDOMIZE_SIDEARM_FORCE_LABEL, IDC_RANDOMIZE_SIDEARM_FORCE_CHECK,
    IDC_RANDOMIZE_SIDEARM_CONTENT_LABEL, IDC_RANDOMIZE_SIDEARM_CONTENT_EDIT,
    IDC_RANDOMIZE_SIDEARM_SCOPE_RANDOM_LABEL, IDC_RANDOMIZE_SIDEARM_SCOPE_RANDOM_CHECK,
    IDC_RANDOMIZE_SIDEARM_SCOPE_CHANCE_LABEL, IDC_RANDOMIZE_SIDEARM_SCOPE_CHANCE_SLIDER,
    IDC_RANDOMIZE_SIDEARM_SCOPE_CONTENT_LABEL, IDC_RANDOMIZE_SIDEARM_SCOPE_CONTENT_EDIT,
    IDC_RANDOMIZE_SIDEARM_RAIL_RANDOM_LABEL, IDC_RANDOMIZE_SIDEARM_RAIL_RANDOM_CHECK,
    IDC_RANDOMIZE_SIDEARM_RAIL_CHANCE_LABEL, IDC_RANDOMIZE_SIDEARM_RAIL_CHANCE_SLIDER,
    IDC_RANDOMIZE_SIDEARM_RAIL_CONTENT_LABEL, IDC_RANDOMIZE_SIDEARM_RAIL_CONTENT_EDIT,
    IDC_RANDOMIZE_SIDEARM_MUZZLE_RANDOM_LABEL, IDC_RANDOMIZE_SIDEARM_MUZZLE_RANDOM_CHECK,
    IDC_RANDOMIZE_SIDEARM_MUZZLE_CHANCE_LABEL, IDC_RANDOMIZE_SIDEARM_MUZZLE_CHANCE_SLIDER,
    IDC_RANDOMIZE_SIDEARM_MUZZLE_CONTENT_LABEL, IDC_RANDOMIZE_SIDEARM_MUZZLE_CONTENT_EDIT,
    IDC_RANDOMIZE_SIDEARM_BIPOD_RANDOM_LABEL, IDC_RANDOMIZE_SIDEARM_BIPOD_RANDOM_CHECK,
    IDC_RANDOMIZE_SIDEARM_BIPOD_CHANCE_LABEL, IDC_RANDOMIZE_SIDEARM_BIPOD_CHANCE_SLIDER,
    IDC_RANDOMIZE_SIDEARM_BIPOD_CONTENT_LABEL, IDC_RANDOMIZE_SIDEARM_BIPOD_CONTENT_EDIT,
    "Sidearm classnames"
] call _addWeaponBlock;

[
    "Secondary weapon", "Secondary",
    IDC_RANDOMIZE_SECONDARY_CATEGORY,
    IDC_RANDOMIZE_SECONDARY_RANDOM_LABEL, IDC_RANDOMIZE_SECONDARY_RANDOM_CHECK,
    IDC_RANDOMIZE_SECONDARY_FORCE_LABEL, IDC_RANDOMIZE_SECONDARY_FORCE_CHECK,
    IDC_RANDOMIZE_SECONDARY_CONTENT_LABEL, IDC_RANDOMIZE_SECONDARY_CONTENT_EDIT,
    IDC_RANDOMIZE_SECONDARY_SCOPE_RANDOM_LABEL, IDC_RANDOMIZE_SECONDARY_SCOPE_RANDOM_CHECK,
    IDC_RANDOMIZE_SECONDARY_SCOPE_CHANCE_LABEL, IDC_RANDOMIZE_SECONDARY_SCOPE_CHANCE_SLIDER,
    IDC_RANDOMIZE_SECONDARY_SCOPE_CONTENT_LABEL, IDC_RANDOMIZE_SECONDARY_SCOPE_CONTENT_EDIT,
    IDC_RANDOMIZE_SECONDARY_RAIL_RANDOM_LABEL, IDC_RANDOMIZE_SECONDARY_RAIL_RANDOM_CHECK,
    IDC_RANDOMIZE_SECONDARY_RAIL_CHANCE_LABEL, IDC_RANDOMIZE_SECONDARY_RAIL_CHANCE_SLIDER,
    IDC_RANDOMIZE_SECONDARY_RAIL_CONTENT_LABEL, IDC_RANDOMIZE_SECONDARY_RAIL_CONTENT_EDIT,
    IDC_RANDOMIZE_SECONDARY_MUZZLE_RANDOM_LABEL, IDC_RANDOMIZE_SECONDARY_MUZZLE_RANDOM_CHECK,
    IDC_RANDOMIZE_SECONDARY_MUZZLE_CHANCE_LABEL, IDC_RANDOMIZE_SECONDARY_MUZZLE_CHANCE_SLIDER,
    IDC_RANDOMIZE_SECONDARY_MUZZLE_CONTENT_LABEL, IDC_RANDOMIZE_SECONDARY_MUZZLE_CONTENT_EDIT,
    IDC_RANDOMIZE_SECONDARY_BIPOD_RANDOM_LABEL, IDC_RANDOMIZE_SECONDARY_BIPOD_RANDOM_CHECK,
    IDC_RANDOMIZE_SECONDARY_BIPOD_CHANCE_LABEL, IDC_RANDOMIZE_SECONDARY_BIPOD_CHANCE_SLIDER,
    IDC_RANDOMIZE_SECONDARY_BIPOD_CONTENT_LABEL, IDC_RANDOMIZE_SECONDARY_BIPOD_CONTENT_EDIT,
    "Secondary weapon classnames"
] call _addWeaponBlock;

call _finalizeCategoryBody;

_display setVariable [QGVAR(onConfirm), QEFUNC(modules,onConfirm_randomizeGear)];
_display setVariable [QGVAR(saveKey), _saveKey];
_display setVariable [QGVAR(importExportEnabled), true];

_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(fields), _fields];
_display setVariable [QGVAR(contentHeight), _y + _contentPaddingY];
