#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Eden module entry point for ACE damage.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic, synchronizedObjects] call mmm_modules_fnc_aceDamageInit
 *
 * Public: No
 */

params [
    ["_logic", objNull, [objNull]],
    ["_objs", [], [[]]]
];

private _projectileValues = [
    "bullet",
    "grenade",
    "explosive",
    "shell",
    "vehiclecrash",
    "collision",
    "backblast",
    "stab",
    "punch",
    "falling",
    "ropeburn",
    "burn",
    "unknown",
    "custom"
];
private _projectileIndex = round (_logic getVariable [QGVAR(aceDamageProjectileType), 0]);

private _settings = [
    _logic getVariable [QGVAR(aceDamageMode), 0],
    [
        _logic getVariable [QGVAR(aceDamageHead), 0.4],
        _logic getVariable [QGVAR(aceDamageBody), 0.4],
        _logic getVariable [QGVAR(aceDamageLeftArm), 0.4],
        _logic getVariable [QGVAR(aceDamageRightArm), 0.4],
        _logic getVariable [QGVAR(aceDamageLeftLeg), 0.4],
        _logic getVariable [QGVAR(aceDamageRightLeg), 0.4]
    ],
    _logic getVariable [QGVAR(aceDamageRandomDamageMax), 0.8],
    _projectileValues param [_projectileIndex, "bullet"],
    _logic getVariable [QGVAR(aceDamageCustomProjectiles), ""],
    _logic getVariable [QGVAR(aceDamageRandomProjectile), false],
    _logic getVariable [QGVAR(aceDamageWoundCount), 1],
    _logic getVariable [QGVAR(aceDamageRandomWoundCount), false],
    _logic getVariable [QGVAR(aceDamageWoundCountMax), 3],
    _logic getVariable [QGVAR(aceDamageRandomBodyPartMax), 1],
    [
        _logic getVariable [QGVAR(aceDamageUseHead), true],
        _logic getVariable [QGVAR(aceDamageUseBody), true],
        _logic getVariable [QGVAR(aceDamageUseLeftArm), true],
        _logic getVariable [QGVAR(aceDamageUseRightArm), true],
        _logic getVariable [QGVAR(aceDamageUseLeftLeg), true],
        _logic getVariable [QGVAR(aceDamageUseRightLeg), true]
    ],
    _logic getVariable [QGVAR(aceDamageApplyForce), false],
    _logic getVariable [QGVAR(aceDamageRandomForce), false],
    _logic getVariable [QGVAR(aceDamageForceVector), "[0,3,4]"],
    _logic getVariable [QGVAR(aceDamageForceMax), 4],
    _logic getVariable [QGVAR(aceDamageOverrideInvulnerability), true],
    _logic getVariable [QGVAR(aceDamageForceDeath), false]
];

[_objs, _settings] call EFUNC(modules,aceDamage);
