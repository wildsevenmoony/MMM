#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Executes full gear randomization after the custom dialog's OK button is
 * pressed.
 *
 * The reusable GUI layer passes values as [key, idc, type, value]. This
 * function converts those values into calls to the existing single equipment
 * randomizers, so the individual modules remain untouched and usable.
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

private _randomizeGroup = ["Group", false] call _getValue;
private _units = if (_randomizeGroup) then {
    units group _target
} else {
    [_target]
};

{
    private _unit = _x;

    if (["BackpacksRandom", false] call _getValue) then {
        [
            _unit,
            true,
            ["BackpacksForce", false] call _getValue,
            ["BackpacksChance", 0] call _getValue,
            ["BackpacksContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearBackpacks);
    };

    if (["GogglesRandom", false] call _getValue) then {
        [
            _unit,
            true,
            ["GogglesForce", false] call _getValue,
            ["GogglesChance", 0] call _getValue,
            ["GogglesContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearGoggles);
    };

    if (["HeadgearRandom", false] call _getValue) then {
        [
            _unit,
            true,
            ["HeadgearForce", false] call _getValue,
            ["HeadgearChance", 0] call _getValue,
            ["HeadgearContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearHeadgear);
    };

    if (["UniformsRandom", false] call _getValue) then {
        [
            _unit,
            true,
            ["UniformsForce", false] call _getValue,
            ["UniformsChance", 0] call _getValue,
            ["UniformsContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearUniforms);
    };

    if (["VestsRandom", false] call _getValue) then {
        [
            _unit,
            true,
            ["VestsForce", false] call _getValue,
            ["VestsChance", 0] call _getValue,
            ["VestsContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearVests);
    };

    if (
        (["PrimaryRandom", false] call _getValue)
        || {["SidearmRandom", false] call _getValue}
        || {["SecondaryRandom", false] call _getValue}
    ) then {
        [
            _unit,
            ["PrimaryRandom", false] call _getValue,
            ["PrimaryForce", false] call _getValue,
            ["PrimaryContent", ""] call _getValue,
            ["PrimaryScopeRandom", false] call _getValue,
            ["PrimaryScopeChance", 0] call _getValue,
            ["PrimaryScopeContent", ""] call _getValue,
            ["PrimaryRailRandom", false] call _getValue,
            ["PrimaryRailChance", 0] call _getValue,
            ["PrimaryRailContent", ""] call _getValue,
            ["PrimaryMuzzleRandom", false] call _getValue,
            ["PrimaryMuzzleChance", 0] call _getValue,
            ["PrimaryMuzzleContent", ""] call _getValue,
            ["PrimaryBipodRandom", false] call _getValue,
            ["PrimaryBipodChance", 0] call _getValue,
            ["PrimaryBipodContent", ""] call _getValue,
            ["SidearmRandom", false] call _getValue,
            ["SidearmForce", false] call _getValue,
            ["SidearmContent", ""] call _getValue,
            ["SidearmScopeRandom", false] call _getValue,
            ["SidearmScopeChance", 0] call _getValue,
            ["SidearmScopeContent", ""] call _getValue,
            ["SidearmRailRandom", false] call _getValue,
            ["SidearmRailChance", 0] call _getValue,
            ["SidearmRailContent", ""] call _getValue,
            ["SidearmMuzzleRandom", false] call _getValue,
            ["SidearmMuzzleChance", 0] call _getValue,
            ["SidearmMuzzleContent", ""] call _getValue,
            ["SidearmBipodRandom", false] call _getValue,
            ["SidearmBipodChance", 0] call _getValue,
            ["SidearmBipodContent", ""] call _getValue,
            ["SecondaryRandom", false] call _getValue,
            ["SecondaryForce", false] call _getValue,
            ["SecondaryContent", ""] call _getValue,
            ["SecondaryScopeRandom", false] call _getValue,
            ["SecondaryScopeChance", 0] call _getValue,
            ["SecondaryScopeContent", ""] call _getValue,
            ["SecondaryRailRandom", false] call _getValue,
            ["SecondaryRailChance", 0] call _getValue,
            ["SecondaryRailContent", ""] call _getValue,
            ["SecondaryMuzzleRandom", false] call _getValue,
            ["SecondaryMuzzleChance", 0] call _getValue,
            ["SecondaryMuzzleContent", ""] call _getValue,
            ["SecondaryBipodRandom", false] call _getValue,
            ["SecondaryBipodChance", 0] call _getValue,
            ["SecondaryBipodContent", ""] call _getValue
        ] call EFUNC(modules,randomizeGearWeapons);
    };
} forEach _units;

if (_randomizeGroup) then {
    [objNull, "GROUP GEAR RANDOMIZED"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
    [objNull, "UNIT GEAR RANDOMIZED"] call BIS_fnc_showCuratorFeedbackMessage;
};

true
