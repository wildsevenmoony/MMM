#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Imports dynamic dialog values from the clipboard and applies them to the
 * currently open dialog.
 *
 * Expected format:
 * MMM_DIALOG_EXPORT_V1
 * Key = value
 *
 * Notes:
 * copyFromClipboard is disabled by Arma in multiplayer for security reasons,
 * so import may only work in local/editor contexts.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Imported values as [key, idc, type, value] <ARRAY>
 */

params ["_display"];

private _clipboard = copyFromClipboard;
if (_clipboard isEqualTo "") exitWith {
    [objNull, "CLIPBOARD EMPTY OR IMPORT DISABLED"] call BIS_fnc_showCuratorFeedbackMessage;
    []
};

private _fields = _display getVariable [QGVAR(fields), []];
private _imported = [];

{
    private _line = [_x] call CBA_fnc_trim;

    if (
        _line isNotEqualTo ""
        && {_line isNotEqualTo "MMM_DIALOG_EXPORT_V1"}
        && {(_line select [0, 2]) isNotEqualTo "//"}
    ) then {
        private _separator = _line find "=";

        if (_separator > 0) then {
            private _key = [_line select [0, _separator]] call CBA_fnc_trim;
            private _rawValue = [_line select [_separator + 1]] call CBA_fnc_trim;
            private _fieldIndex = _fields findIf {(_x select 0) isEqualTo _key};

            if (_fieldIndex != -1) then {
                private _field = _fields select _fieldIndex;
                _field params ["", "_idc", "_type"];

                private _value = switch (_type) do {
                    case "checkbox": {
                        private _lower = toLowerANSI _rawValue;
                        _lower in ["true", "1", "yes", "y"]
                    };
                    case "slider": {
                        parseNumber _rawValue
                    };
                    case "edit": {
                        if ((_rawValue select [0, 1]) in ["""", "'"]) then {
                            private _parsed = parseSimpleArray format ["[%1]", _rawValue];
                            _parsed param [0, "", [""]]
                        } else {
                            _rawValue
                        }
                    };
                    case "combo": {
                        if ((_rawValue select [0, 1]) in ["""", "'"]) then {
                            private _parsed = parseSimpleArray format ["[%1]", _rawValue];
                            _parsed param [0, "", [""]]
                        } else {
                            _rawValue
                        }
                    };
                    default {
                        nil
                    };
                };

                private _control = _display displayCtrl _idc;
                if (!isNull _control) then {
                    switch (_type) do {
                        case "checkbox": {
                            _control cbSetChecked _value;

                            private _toggleControls = _control getVariable [QGVAR(toggleControls), []];
                            if (_toggleControls isNotEqualTo []) then {
                                _toggleControls params ["_buttonNo", "_buttonYes"];
                                private _setToggleVisuals = _control getVariable QGVAR(setToggleVisuals);
                                [_control, _buttonNo, _buttonYes, _value] call _setToggleVisuals;
                            };
                        };
                        case "slider": {
                            _control sliderSetPosition _value;

                            private _valueEdit = _control getVariable [QGVAR(valueEdit), controlNull];
                            if (!isNull _valueEdit) then {
                                private _formatSliderValue = _control getVariable QGVAR(formatSliderValue);
                                _valueEdit ctrlSetText ([_value] call _formatSliderValue);
                            };
                        };
                        case "edit": {
                            _control ctrlSetText _value;
                        };
                        case "combo": {
                            private _index = 0;
                            for "_i" from 0 to ((lbSize _control) - 1) do {
                                if ((_control lbData _i) isEqualTo _value) exitWith {
                                    _index = _i;
                                };
                            };
                            _control lbSetCurSel _index;
                        };
                    };
                };

                _imported pushBack [_key, _idc, _type, _value];
            };
        };
    };
} forEach (_clipboard splitString toString [13, 10]);

if (_imported isEqualTo []) then {
    [objNull, "NO VALID DIALOG VALUES FOUND"] call BIS_fnc_showCuratorFeedbackMessage;
} else {
    [objNull, "DIALOG VALUES IMPORTED"] call BIS_fnc_showCuratorFeedbackMessage;
};

_imported
