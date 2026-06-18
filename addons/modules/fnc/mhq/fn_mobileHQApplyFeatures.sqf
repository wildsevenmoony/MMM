/*
 * Author: Moony
 * Applies or removes MHQ features that depend on deployment.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]]
];

if (!isServer || {isNull _mhq}) exitWith {};

private _deployed = _mhq getVariable [QGVAR(mhqDeployed), false];

if (
    _deployed
    && {missionNamespace getVariable [QGVAR(mhqBaseMedicEnabled), false]}
    && {!(_mhq getVariable [QGVAR(baseMedic), false])}
) then {
    [_mhq, "Heal me", "Heal everyone", "alive _target && {_target getVariable ['MMM_modules_mhqDeployed', false]}"] call EFUNC(modules,baseMedic);
};

if (isNil "ace_arsenal_fnc_initBox") exitWith {};

private _arsenalActive = _mhq getVariable [QGVAR(mhqArsenalActive), false];
private _arsenalShouldBeActive = _deployed && {missionNamespace getVariable [QGVAR(mhqArsenalEnabled), false]};

if (_arsenalShouldBeActive && {!_arsenalActive}) then {
    private _items = [missionNamespace getVariable [QGVAR(mhqArsenalItems), ""]] call EFUNC(modules,mobileHQParseArsenalItems);

    if (_items isEqualTo []) then {
        [_mhq, true] call ace_arsenal_fnc_initBox;
    } else {
        [_mhq, _items] call ace_arsenal_fnc_initBox;
    };

    _mhq setVariable [QGVAR(mhqArsenalActive), true, true];
};

if (!_arsenalShouldBeActive && _arsenalActive) then {
    if (isNil "ace_arsenal_fnc_removeBox") then {
        _mhq setVariable ["ace_arsenal_virtualItems", nil, true];
        _mhq setVariable ["ace_arsenal_virtualBackpacks", nil, true];
        _mhq setVariable ["ace_arsenal_virtualMagazines", nil, true];
        _mhq setVariable ["ace_arsenal_virtualWeapons", nil, true];
    } else {
        [_mhq] call ace_arsenal_fnc_removeBox;
    };

    _mhq setVariable [QGVAR(mhqArsenalActive), false, true];
};
