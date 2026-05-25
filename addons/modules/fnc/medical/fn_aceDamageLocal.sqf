#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Local worker for the ACE damage module. The public wrapper remoteExecs this
 * to the machine that owns the unit, which keeps ACE medical state changes and
 * ragdoll force in the right locality.
 *
 * Settings:
 * 0 mode <NUMBER> 0 specific, 1 random per body part, 2 random body parts
 * 1 specific damages <ARRAY>
 * 2 max random damage <NUMBER>
 * 3 projectile type <STRING>
 * 4 custom projectile types <STRING>
 * 5 random projectile <BOOL>
 * 6 wound count <NUMBER>
 * 7 random wound count <BOOL>
 * 8 max random wounds <NUMBER>
 * 9 max random body parts <NUMBER>
 * 10 enabled body parts <ARRAY>
 * 11 apply force <BOOL>
 * 12 random force <BOOL>
 * 13 force vector text <STRING>
 * 14 max random force <NUMBER>
 * 15 override invulnerability <BOOL>
 * 16 force death after damage <BOOL>
 *
 * Return Value:
 * None
 */

params [
    ["_unit", objNull, [objNull]],
    ["_settings", [], [[]]]
];

if (isNull _unit || {!local _unit} || {!alive _unit}) exitWith {};
if !(["ace_medical"] call ace_common_fnc_isModLoaded) exitWith {};

private _toNumber = {
    params ["_value", ["_default", 0]];

    if (_value isEqualType 0) exitWith {_value};
    if (_value isEqualType "") exitWith {
        private _trimmed = [_value] call CBA_fnc_trim;
        if (_trimmed isEqualTo "") then {_default} else {parseNumber _trimmed}
    };

    _default
};

private _parseList = {
    params ["_text"];

    if !(_text isEqualType "") exitWith {[]};

    private _items = [];
    {
        private _item = [_x] call CBA_fnc_trim;
        if (_item isNotEqualTo "") then {
            _items pushBackUnique _item;
        };
    } forEach (_text splitString ",;");

    _items
};

private _bodyParts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
private _defaultProjectiles = [
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
    "unknown"
];

private _katLoaded = ["kat_main"] call ace_common_fnc_isModLoaded;
if (_katLoaded) then {
    {
        _defaultProjectiles pushBackUnique _x;
    } forEach ["bullet", "stab", "explosive"];
};

private _mode = [_settings param [0, 0], 0] call _toNumber;
private _specificDamages = _settings param [1, [0.4, 0.4, 0.4, 0.4, 0.4, 0.4], [[]]];
private _randomDamageMax = 0 max ([_settings param [2, 0.8], 0.8] call _toNumber);
private _projectileType = _settings param [3, "bullet", [""]];
private _customProjectiles = [_settings param [4, "", [""]]] call _parseList;
private _randomProjectile = _settings param [5, false, [false]];
private _woundCount = 1 max round ([_settings param [6, 1], 1] call _toNumber);
private _randomWoundCount = _settings param [7, false, [false]];
private _woundCountMax = 1 max round ([_settings param [8, 3], 3] call _toNumber);
private _randomBodyPartMax = round ([_settings param [9, 1], 1] call _toNumber);
private _enabledParts = _settings param [10, [true, true, true, true, true, true], [[]]];
private _applyForce = _settings param [11, false, [false]];
private _randomForce = _settings param [12, false, [false]];
private _forceVectorText = _settings param [13, "[0,3,4]", [""]];
private _forceMax = 0 max ([_settings param [14, 4], 4] call _toNumber);
private _overrideInvulnerability = _settings param [15, true, [false]];
private _forceDeath = _settings param [16, false, [false]];

private _projectiles = +_defaultProjectiles;
{_projectiles pushBackUnique _x} forEach _customProjectiles;

private _getProjectile = {
    if (_randomProjectile && {_projectiles isNotEqualTo []}) exitWith {
        selectRandom _projectiles
    };

    if (_projectileType isEqualTo "custom") exitWith {
        _customProjectiles param [0, "bullet", [""]]
    };

    if (_projectileType isEqualTo "") exitWith {"bullet"};

    _projectileType
};

private _getDamage = {
    params ["_partIndex"];

    switch (_mode) do {
        case 0: {
            0 max ([_specificDamages param [_partIndex, 0], 0] call _toNumber)
        };
        default {
            random _randomDamageMax
        };
    }
};

private _getWoundCount = {
    if (_randomWoundCount) exitWith {
        1 + floor random _woundCountMax
    };

    _woundCount
};

private _selectedPartIndexes = [];
{
    if (_enabledParts param [_forEachIndex, true, [false]]) then {
        _selectedPartIndexes pushBack _forEachIndex;
    };
} forEach _bodyParts;

if (_selectedPartIndexes isEqualTo [] && {!_forceDeath}) exitWith {};

private _applyWound = {
    params ["_partIndex"];

    private _damage = [_partIndex] call _getDamage;
    if (_damage <= 0) exitWith {};

    [
        _unit,
        _damage,
        _bodyParts select _partIndex,
        call _getProjectile,
        objNull,
        [],
        _overrideInvulnerability
    ] call ace_medical_fnc_addDamageToUnit;
};

if (_selectedPartIndexes isNotEqualTo []) then {
    switch (_mode) do {
        case 2: {
            private _partCount = if (_randomBodyPartMax <= 0) then {
                count _selectedPartIndexes
            } else {
                1 + floor random (_randomBodyPartMax min (count _selectedPartIndexes))
            };
            private _randomPartIndexes = +_selectedPartIndexes;
            _randomPartIndexes = _randomPartIndexes call BIS_fnc_arrayShuffle;
            _randomPartIndexes resize _partCount;

            for "_i" from 1 to (call _getWoundCount) do {
                [selectRandom _randomPartIndexes] call _applyWound;
            };
        };
        default {
            {
                private _partIndex = _x;
                for "_i" from 1 to (call _getWoundCount) do {
                    [_partIndex] call _applyWound;
                };
            } forEach _selectedPartIndexes;
        };
    };
};

if (_applyForce) then {
    private _force = [0, 3, 4];

    if (_randomForce) then {
        _force = [
            (random (_forceMax * 2)) - _forceMax,
            (random (_forceMax * 2)) - _forceMax,
            random _forceMax
        ];

        _unit setDir (random 360);
    } else {
        private _parsed = parseSimpleArray _forceVectorText;
        if (_parsed isEqualType [] && {count _parsed >= 3}) then {
            _force = [
                [_parsed param [0, 0], 0] call _toNumber,
                [_parsed param [1, 3], 3] call _toNumber,
                [_parsed param [2, 4], 4] call _toNumber
            ];
        };
    };

    _unit addForce [_force vectorMultiply 75, [0, 0, 1]];
    _unit setVelocity ((velocity _unit) vectorAdd _force);
};

if (_forceDeath) then {
    _unit setDamage 1;
};
