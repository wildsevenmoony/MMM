/*
 * Author: Moony
 * Parses the MHQ ACE Arsenal CBA item list.
 *
 * Arguments:
 * 0: Raw item list <STRING>
 *
 * Return Value:
 * Item classnames <ARRAY>
 *
 * Example:
 * ['"arifle_MX_F", FirstAidKit'] call mmm_modules_fnc_mobileHQParseArsenalItems
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_rawItems", "", [""]]
];

private _trimmed = [_rawItems] call CBA_fnc_trim;

if (_trimmed isEqualTo "" || {_trimmed isEqualTo "[]"}) exitWith {[]};

private _items = ([_trimmed] call CBA_fnc_removeWhitespace) splitString ",";

_items apply {
    private _item = _x;

    if (_item isEqualTo "") exitWith {""};

    if ((_item select [0, 1]) in ["'", """"]) then {
        _item = _item select [1, count _item - 1];
    };

    if (_item isNotEqualTo "" && {(_item select [count _item - 1, 1]) in ["'", """"]}) then {
        _item = _item select [0, count _item - 1];
    };

    _item
} select {_x isNotEqualTo ""}
