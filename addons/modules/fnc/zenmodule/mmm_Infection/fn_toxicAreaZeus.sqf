/*
 * Author: Moony
 * Creates an MMA toxic infection area from a ZEN custom module.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_position", [], [[]]],
    ["_objectUnderCursor", objNull, [objNull]]
];

private _source = _objectUnderCursor;
if (isNull _source) then {
    _source = "Land_HelipadEmpty_F" createVehicle _position;
};

[
    "Toxic Area",
    [
        [
            "SLIDER",
            ["Radius", "Radius of the toxic infection area in meters. Use the custom radius field for values above 500."],
            [1, 500, 20, 0]
        ],
        [
            "EDIT",
            ["Custom Radius", "Optional radius override. Leave empty to use the slider."],
            "",
            false
        ],
        [
            "CHECKBOX",
            ["Source Mist", "Creates light toxic leakage mist directly around the source object."],
            true,
            false
        ]
    ],
    {
        params ["_dialogValues", "_source"];
        _dialogValues params ["_radius", "_customRadius", "_sourceMist"];
        private _radiusOverride = parseNumber _customRadius;
        if (_radiusOverride > 0) then {
            _radius = _radiusOverride;
        };

        [_source, _radius, _sourceMist] remoteExecCall ["MMA_fnc_toxicAreaCreate", 2];

        [objNull, format ["TOXIC AREA CREATED (%1M)", round _radius]] call BIS_fnc_showCuratorFeedbackMessage;
    },
    {},
    _source
] call zen_dialog_fnc_create;

[_source] spawn {
    params ["_source"];

    waitUntil {
        !isNull (uiNamespace getVariable ["zen_common_display", displayNull])
    };

    private _display = uiNamespace getVariable ["zen_common_display", displayNull];
    private _dialogParams = _display getVariable ["zen_dialog_params", []];
    if (_dialogParams isEqualTo []) exitWith {};

    private _rows = _dialogParams select 0;
    private _radiusRow = (_rows select 0) select 0;
    private _customRadiusRow = (_rows select 1) select 0;
    private _slider = _radiusRow controlsGroupCtrl 1005;
    private _customEdit = _customRadiusRow controlsGroupCtrl 1004;

    [
        {
            params ["_args", "_handle"];
            _args params ["_source", "_display", "_slider", "_customEdit"];

            if (isNull _display || {isNull _slider} || {isNull _customEdit} || {isNull _source}) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            private _radius = sliderPosition _slider;
            private _customRadius = parseNumber ctrlText _customEdit;
            if (_customRadius > 0) then {
                _radius = _customRadius;
            };

            _radius = (_radius max 1) min 20000;

            private _segments = (ceil (_radius / 5)) max 32 min 360;
            private _previousPos = [];
            for "_i" from 0 to _segments do {
                private _angle = 360 * (_i / _segments);
                private _pos = _source getPos [_radius, _angle];
                _pos set [2, 0.12];

                if (_previousPos isNotEqualTo []) then {
                    drawLine3D [_previousPos, _pos, [1, 1, 1, 0.85]];
                };

                _previousPos = _pos;
            };
        },
        0,
        [_source, _display, _slider, _customEdit]
    ] call CBA_fnc_addPerFrameHandler;
};
