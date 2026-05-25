/*
 * Author: Moony
 * Parses a comma-separated classname list from module or dialog input.
 *
 * Arguments:
 * 0: Raw classnames <STRING>
 *
 * Return Value:
 * Parsed classnames, or [""] when input is empty <ARRAY>
 *
 * Example:
 * ["arifle_MX_F, arifle_Katiba_F"] call mmm_modules_fnc_parseClassnameList
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_classNames", "", [""]]
];

if (_classNames isEqualTo "" || {_classNames isEqualTo "[]"}) exitWith {
	[""]
};

([_classNames] call CBA_fnc_removeWhitespace) splitString ","
