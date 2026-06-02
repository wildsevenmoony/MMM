#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Executes ACE damage after the Zeus dialog is confirmed.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Values as [key, idc, type, value] <ARRAY>
 * 2: Extra arguments. 0 is the target unit selected in Zeus <ARRAY>
 *
 * Return Value:
 * Close dialog <BOOL>
 */

params ["_display", "_values", "_arguments"];

private _target = _arguments param [0, objNull, [objNull]];
if (isNull _target) exitWith {
    [objNull, "NO UNIT SELECTED"] call BIS_fnc_showCuratorFeedbackMessage;
    false
};

private _getValue = {
    params ["_key", "_default"];

    private _index = _values findIf {(_x select 0) isEqualTo _key};
    if (_index == -1) exitWith {_default};

    (_values select _index) select 3
};

private _getNumber = {
    params ["_key", "_default"];

    private _value = [_key, _default] call _getValue;
    if (_value isEqualType 0) exitWith {_value};
    parseNumber _value
};

private _settings = [
    ["Mode", "0"] call _getNumber,
    [
        ["HeadDamage", "0.4"] call _getNumber,
        ["BodyDamage", "0.4"] call _getNumber,
        ["LeftArmDamage", "0.4"] call _getNumber,
        ["RightArmDamage", "0.4"] call _getNumber,
        ["LeftLegDamage", "0.4"] call _getNumber,
        ["RightLegDamage", "0.4"] call _getNumber
    ],
    ["RandomDamageMax", "0.8"] call _getNumber,
    ["Projectile", "bullet"] call _getValue,
    ["CustomProjectiles", ""] call _getValue,
    ["RandomProjectile", false] call _getValue,
    ["WoundCount", "1"] call _getNumber,
    ["RandomWounds", false] call _getValue,
    ["MaxWounds", "3"] call _getNumber,
    ["RandomPartMax", "1"] call _getNumber,
    [
        ["UseHead", true] call _getValue,
        ["UseBody", true] call _getValue,
        ["UseLeftArm", true] call _getValue,
        ["UseRightArm", true] call _getValue,
        ["UseLeftLeg", true] call _getValue,
        ["UseRightLeg", true] call _getValue
    ],
    ["ApplyForce", false] call _getValue,
    ["RandomForce", false] call _getValue,
    ["ForceVector", "[0,3,4]"] call _getValue,
    ["ForceMax", "4"] call _getNumber,
    ["OverrideInvulnerability", true] call _getValue,
    ["ForceDeath", false] call _getValue,
    ["RandomProjectiles", ""] call _getValue,
    ["RandomDamageMin", "0"] call _getNumber,
    ["MinWounds", "1"] call _getNumber,
    ["RandomPartMin", "1"] call _getNumber,
    ["ForceMin", "0"] call _getNumber
];

[[_target], _settings] call EFUNC(modules,aceDamage);

[objNull, "ACE DAMAGE APPLIED"] call BIS_fnc_showCuratorFeedbackMessage;

true
