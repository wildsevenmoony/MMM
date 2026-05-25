#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Builds the ACE damage Zeus dialog.
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
    _title ctrlSetText "Apply ACE Damage";
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
private _saveKey = QGVAR(aceDamageDialogValues);
private _savedValues = profileNamespace getVariable [_saveKey, []];
private _y = _contentPaddingY;

#include "\z\mmm\addons\modules\fnc\zenmodule\gui\script_guiHelpers.hpp"

private _addCombo = {
    params ["_label", "_labelIdc", "_comboIdc", "_items", ["_default", ""], ["_key", ""], ["_tooltip", ""]];

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
    private _combo = ["RscCombo", _comboIdc, [_fieldX, _y, _rowWField, _rowH]] call _addControl;

    private _defaultIndex = 0;
    {
        _x params ["_name", "_value"];

        private _index = _combo lbAdd _name;
        _combo lbSetData [_index, _value];

        if (_value isEqualTo _default) then {
            _defaultIndex = _forEachIndex;
        };
    } forEach _items;

    _combo lbSetCurSel _defaultIndex;
    _fields pushBack [_key, _comboIdc, "combo"];
    _y = _y + _rowH + _rowGap;

    _combo
};

private _projectiles = [
    ["Bullet", "bullet"],
    ["Grenade", "grenade"],
    ["Explosive", "explosive"],
    ["Shell", "shell"],
    ["Vehicle crash", "vehiclecrash"],
    ["Collision", "collision"],
    ["Backblast", "backblast"],
    ["Stab", "stab"],
    ["Punch", "punch"],
    ["Falling", "falling"],
    ["Rope burn", "ropeburn"],
    ["Burn", "burn"],
    ["Unknown", "unknown"],
    ["Custom first", "custom"]
];

if (["kat_main"] call ace_common_fnc_isModLoaded) then {
    _projectiles pushBackUnique ["KAT compatible: Stab", "stab"];
};

[
    "Damage Mode",
    IDC_ACE_DAMAGE_MODE_LABEL,
    IDC_ACE_DAMAGE_MODE_COMBO,
    [
        ["Specific damage to selected body parts", "0"],
        ["Random damage to selected body parts", "1"],
        ["Random damage to random body parts", "2"]
    ],
    "0",
    "Mode",
    "Choose how damage values and body parts are selected."
] call _addCombo;

["Projectile", IDC_ACE_DAMAGE_PROJECTILE_LABEL, IDC_ACE_DAMAGE_PROJECTILE_COMBO, _projectiles, "bullet", "Projectile", "Damage source type passed into ACE medical damage handling."] call _addCombo;
["Custom projectiles", IDC_ACE_DAMAGE_CUSTOM_PROJECTILES_LABEL, IDC_ACE_DAMAGE_CUSTOM_PROJECTILES_EDIT, "", "CustomProjectiles", "Comma-separated custom projectile type names used when random projectile is enabled."] call _addEdit;
["Random projectile", IDC_ACE_DAMAGE_RANDOM_PROJECTILE_LABEL, IDC_ACE_DAMAGE_RANDOM_PROJECTILE_CHECK, false, "RandomProjectile", "Pick a random projectile type instead of using the selected projectile."] call _addCheckbox;

["Wounds", IDC_ACE_DAMAGE_WOUNDS_CATEGORY] call _addCategory;
["Wound count", IDC_ACE_DAMAGE_WOUND_COUNT_LABEL, IDC_ACE_DAMAGE_WOUND_COUNT_EDIT, "1", "WoundCount", "Number of wounds applied when random wound count is disabled."] call _addEdit;
["Random wound count", IDC_ACE_DAMAGE_RANDOM_WOUNDS_LABEL, IDC_ACE_DAMAGE_RANDOM_WOUNDS_CHECK, false, "RandomWounds", "Randomize how many wounds are applied."] call _addCheckbox;
["Max random wounds", IDC_ACE_DAMAGE_MAX_WOUNDS_LABEL, IDC_ACE_DAMAGE_MAX_WOUNDS_EDIT, "3", "MaxWounds", "Upper limit for randomized wound count."] call _addEdit;
["Max random body parts", IDC_ACE_DAMAGE_RANDOM_PART_MAX_LABEL, IDC_ACE_DAMAGE_RANDOM_PART_MAX_EDIT, "1", "RandomPartMax", "Maximum number of body parts selected when the mode randomizes body parts."] call _addEdit;
["Max random damage", IDC_ACE_DAMAGE_RANDOM_DAMAGE_MAX_LABEL, IDC_ACE_DAMAGE_RANDOM_DAMAGE_MAX_EDIT, [0, 2], 0.8, "RandomDamageMax", [0.05, 0.2], "Upper limit used when randomizing damage values."] call _addSlider;
["Override invulnerability", IDC_ACE_DAMAGE_OVERRIDE_LABEL, IDC_ACE_DAMAGE_OVERRIDE_CHECK, true, "OverrideInvulnerability", "Temporarily allows damage even if the target is protected from damage."] call _addCheckbox;
["Force death", IDC_ACE_DAMAGE_FORCE_DEATH_LABEL, IDC_ACE_DAMAGE_FORCE_DEATH_CHECK, false, "ForceDeath", "Force the target to die after applying the configured damage."] call _addCheckbox;

["Body Parts", IDC_ACE_DAMAGE_PARTS_CATEGORY] call _addCategory;
["Use Head", IDC_ACE_DAMAGE_USE_HEAD_LABEL, IDC_ACE_DAMAGE_USE_HEAD_CHECK, true, "UseHead", "Allow damage to be applied to the head."] call _addCheckbox;
["Head damage", IDC_ACE_DAMAGE_HEAD_LABEL, IDC_ACE_DAMAGE_HEAD_EDIT, "0.4", "HeadDamage", "Damage value used for the head when not randomized."] call _addEdit;
["Use Body", IDC_ACE_DAMAGE_USE_BODY_LABEL, IDC_ACE_DAMAGE_USE_BODY_CHECK, true, "UseBody", "Allow damage to be applied to the torso."] call _addCheckbox;
["Body damage", IDC_ACE_DAMAGE_BODY_LABEL, IDC_ACE_DAMAGE_BODY_EDIT, "0.4", "BodyDamage", "Damage value used for the torso when not randomized."] call _addEdit;
["Use Left Arm", IDC_ACE_DAMAGE_USE_LEFT_ARM_LABEL, IDC_ACE_DAMAGE_USE_LEFT_ARM_CHECK, true, "UseLeftArm", "Allow damage to be applied to the left arm."] call _addCheckbox;
["Left Arm damage", IDC_ACE_DAMAGE_LEFT_ARM_LABEL, IDC_ACE_DAMAGE_LEFT_ARM_EDIT, "0.4", "LeftArmDamage", "Damage value used for the left arm when not randomized."] call _addEdit;
["Use Right Arm", IDC_ACE_DAMAGE_USE_RIGHT_ARM_LABEL, IDC_ACE_DAMAGE_USE_RIGHT_ARM_CHECK, true, "UseRightArm", "Allow damage to be applied to the right arm."] call _addCheckbox;
["Right Arm damage", IDC_ACE_DAMAGE_RIGHT_ARM_LABEL, IDC_ACE_DAMAGE_RIGHT_ARM_EDIT, "0.4", "RightArmDamage", "Damage value used for the right arm when not randomized."] call _addEdit;
["Use Left Leg", IDC_ACE_DAMAGE_USE_LEFT_LEG_LABEL, IDC_ACE_DAMAGE_USE_LEFT_LEG_CHECK, true, "UseLeftLeg", "Allow damage to be applied to the left leg."] call _addCheckbox;
["Left Leg damage", IDC_ACE_DAMAGE_LEFT_LEG_LABEL, IDC_ACE_DAMAGE_LEFT_LEG_EDIT, "0.4", "LeftLegDamage", "Damage value used for the left leg when not randomized."] call _addEdit;
["Use Right Leg", IDC_ACE_DAMAGE_USE_RIGHT_LEG_LABEL, IDC_ACE_DAMAGE_USE_RIGHT_LEG_CHECK, true, "UseRightLeg", "Allow damage to be applied to the right leg."] call _addCheckbox;
["Right Leg damage", IDC_ACE_DAMAGE_RIGHT_LEG_LABEL, IDC_ACE_DAMAGE_RIGHT_LEG_EDIT, "0.4", "RightLegDamage", "Damage value used for the right leg when not randomized."] call _addEdit;

["Force", IDC_ACE_DAMAGE_FORCE_CATEGORY] call _addCategory;
["Apply force", IDC_ACE_DAMAGE_APPLY_FORCE_LABEL, IDC_ACE_DAMAGE_APPLY_FORCE_CHECK, false, "ApplyForce", "Apply a physical force vector after damage is added."] call _addCheckbox;
["Random force", IDC_ACE_DAMAGE_RANDOM_FORCE_LABEL, IDC_ACE_DAMAGE_RANDOM_FORCE_CHECK, false, "RandomForce", "Randomize the force vector instead of using the fixed vector."] call _addCheckbox;
["Force vector", IDC_ACE_DAMAGE_FORCE_VECTOR_LABEL, IDC_ACE_DAMAGE_FORCE_VECTOR_EDIT, "[0,3,4]", "ForceVector", "Fixed force vector in SQF array format, e.g. [0,3,4]."] call _addEdit;
["Max random force", IDC_ACE_DAMAGE_FORCE_MAX_LABEL, IDC_ACE_DAMAGE_FORCE_MAX_EDIT, [0, 10], 4, "ForceMax", [0.25, 1], "Maximum force magnitude used when random force is enabled."] call _addSlider;

call _finalizeCategoryBody;

_display setVariable [QGVAR(onConfirm), QEFUNC(modules,onConfirm_aceDamage)];
_display setVariable [QGVAR(saveKey), _saveKey];
_display setVariable [QGVAR(importExportEnabled), true];

_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(fields), _fields];
_display setVariable [QGVAR(contentHeight), _y + _contentPaddingY];
