#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Applies configured ACE medical damage to one or more units.
 *
 * Arguments:
 * 0: Unit or units <OBJECT|ARRAY>
 * 1: Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[player], [0, [0.4,0.4,0.4,0.4,0.4,0.4], 0.8, "bullet", "", false, 1, false, 3, 1, [true,true,true,true,true,true], false, false, "[0,3,4]", 4, true, false]] call mmm_modules_fnc_aceDamage
 *
 * Public: No
 */

params [
    ["_targets", [], [objNull, []]],
    ["_settings", [], [[]]]
];

if (_targets isEqualType objNull) then {
    _targets = [_targets];
};

if !(["ace_medical"] call ace_common_fnc_isModLoaded) exitWith {
    diag_log "[MMM] ACE Damage module ignored because ace_medical is not loaded.";
};

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
    diag_log format ["[%1] ACE damage requested for %2 target(s)", QADDON, count _targets];
};

{
    if (!isNull _x && {_x isKindOf "CAManBase"} && {alive _x}) then {
        [_x, _settings] remoteExecCall [QEFUNC(modules,aceDamageLocal), _x];
    };
} forEach _targets;
