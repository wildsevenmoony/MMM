#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Adds an Ace Arsenal to the Object.
 *
 * Arguments:
 * 0: Unit or units <OBJECT|ARRAY>
 * 1: Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[MyObject], [false, "", false, ""]] call mmm_modules_fnc_aceArsenal;
 *
 * Public: No
 */

private _objects = _this param [0, [], [objNull, []]];
private _settingsOrScroll = _this param [1, [], [[], false]];

private _addScrollAction = false;
private _blacklistRaw = "";
private _limited = false;
private _limitedItemsRaw = "";
private _addCompatibleMagazines = false;
private _addCompatibleAttachments = false;

if (_settingsOrScroll isEqualType []) then {
	_addScrollAction = _settingsOrScroll param [0, false, [false]];
	_blacklistRaw = _settingsOrScroll param [1, "", ["", []]];
	_limited = _settingsOrScroll param [2, false, [false]];
	_limitedItemsRaw = _settingsOrScroll param [3, "", ["", []]];
	_addCompatibleMagazines = _settingsOrScroll param [4, false, [false]];
	_addCompatibleAttachments = _settingsOrScroll param [5, false, [false]];
} else {
	_addScrollAction = _settingsOrScroll;
	_blacklistRaw = _this param [2, "", ["", []]];
	_limited = _this param [3, false, [false]];
	_limitedItemsRaw = _this param [4, "", ["", []]];
	_addCompatibleMagazines = _this param [5, false, [false]];
	_addCompatibleAttachments = _this param [6, false, [false]];
};

if (_objects isEqualType objNull) then {
	_objects = [_objects];
};

if (!isServer) exitWith {};

if (isNil "ace_arsenal_fnc_initBox") exitWith {
	diag_log format ["[%1] ACE Arsenal module skipped because ACE Arsenal is not loaded.", QADDON];
};

private _parseItems = {
	params [["_raw", "", ["", []]]];

	if (_raw isEqualType []) exitWith {
		(_raw apply {if (_x isEqualType "") then {_x} else {str _x}}) select {_x isNotEqualTo ""}
	};

	[_raw] call EFUNC(modules,mobileHQParseArsenalItems)
};

private _blacklist = [_blacklistRaw] call _parseItems;
private _limitedItems = [_limitedItemsRaw] call _parseItems;

if (_limited) then {
	private _expandedItems = +_limitedItems;

	if (_addCompatibleMagazines) then {
		{
			{
				_expandedItems pushBackUnique _x;
			} forEach ([_x] call CBA_fnc_compatibleMagazines);
		} forEach _limitedItems;
	};

	if (_addCompatibleAttachments) then {
		{
			{
				_expandedItems pushBackUnique _x;
			} forEach ([_x] call CBA_fnc_compatibleItems);
		} forEach _limitedItems;
	};

	_limitedItems = _expandedItems;
};

private _arsenalItems = [true, _limitedItems] select _limited;

{
	private _object = _x;
	if (!isNull _object && {!(_object isKindOf "Logic")}) then {
		_object setVariable [QGVAR(aceArsenalInitialized), true, true];
		_object setVariable [QGVAR(aceArsenalScrollAction), _addScrollAction, true];
		_object setVariable [QGVAR(aceArsenalBlacklist), _blacklistRaw, true];
		_object setVariable [QGVAR(aceArsenalLimited), _limited, true];
		_object setVariable [QGVAR(aceArsenalLimitedItems), _limitedItemsRaw, true];
		_object setVariable [QGVAR(aceArsenalAddCompatibleMagazines), _addCompatibleMagazines, true];
		_object setVariable [QGVAR(aceArsenalAddCompatibleAttachments), _addCompatibleAttachments, true];

		if (_limited && {_limitedItems isEqualTo []}) then {
			diag_log format ["[%1] Limited ACE Arsenal on %2 has no whitelist items. ACE interaction is added but the arsenal may not open until items are added.", QADDON, _object];
		};

		[_object, _arsenalItems, true] call ace_arsenal_fnc_initBox;

		if (_blacklist isNotEqualTo [] && {!isNil "ace_arsenal_fnc_removeVirtualItems"}) then {
			[_object, _blacklist, true] call ace_arsenal_fnc_removeVirtualItems;
		};

		[
			[_object, _addScrollAction],
			{
				params ["_object", "_enabled"];
				[_object, _enabled] call mmm_modules_fnc_aceArsenalScrollActionLocal;
			}
		] remoteExec ["spawn", 0, true];
	};
} forEach _objects;
