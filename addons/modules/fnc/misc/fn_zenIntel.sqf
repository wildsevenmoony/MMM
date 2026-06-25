#include "\z\mmm\addons\modules\script_component.hpp"

/*
 * Author: Moony
 * Adds or updates Zeus Enhanced style intel actions on objects from Eden.
 *
 * Arguments:
 * 0: Object or objects <OBJECT|ARRAY>
 * 1: Settings <ARRAY>
 *    0: Share with, 0 side, 1 group, 2 finder only <NUMBER>
 *    1: Delete on completion <BOOL>
 *    2: Action type, 0 hold action, 1 ACE interaction <NUMBER>
 *    3: Action text <STRING>
 *    4: Action sound preset, 0 none, 1 laptop, 2 PC, 3 search body <NUMBER|ARRAY>
 *    5: Action duration <NUMBER>
 *    6: Intel title <STRING>
 *    7: Intel text <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [laptop, [0, true, 1, "Search Laptop", 1, 5, "Orders", "Move at dawn."]] call mmm_modules_fnc_zenIntel
 *
 * Public: No
 */

params [
	["_objects", [], [objNull, []]],
	["_settings", [], [[]]]
];

if (_objects isEqualType objNull) then {
	_objects = [_objects];
};

if (!isServer) exitWith {
	[_objects, _settings] remoteExecCall [QEFUNC(modules,zenIntel), 2];
};

private _share = round (_settings param [0, 0, [0]]);
private _delete = _settings param [1, true, [true]];
private _actionType = round (_settings param [2, 0, [0]]);
private _actionText = _settings param [3, "Pick Up Intel", [""]];
private _soundPreset = _settings param [4, 0, [0, []]];
private _duration = _settings param [5, 1, [0]];
private _title = _settings param [6, "Intel", [""]];
private _text = _settings param [7, "", [""]];

_share = 0 max _share min 2;
_actionType = 0 max _actionType min 1;
_duration = 0 max _duration;

if (_actionText isEqualTo "") then {
	_actionText = "Pick Up Intel";
};
if (_title isEqualTo "") then {
	_title = "Intel";
};

private _soundSets = [
	[],
	["OMIntelGrabLaptop_01", "OMIntelGrabLaptop_02", "OMIntelGrabLaptop_03"],
	["OMIntelGrabPC_01", "OMIntelGrabPC_02", "OMIntelGrabPC_03"],
	["OMIntelGrabBody_01", "OMIntelGrabBody_02", "OMIntelGrabBody_03"]
];

private _actionSounds = if (_soundPreset isEqualType []) then {
	_soundPreset
} else {
	private _soundIndex = round _soundPreset;
	_soundIndex = 0 max _soundIndex min ((count _soundSets) - 1);
	_soundSets select _soundIndex
};

private _diaryText = _text splitString endl joinString "<br />";

{
	private _object = _x;
	if (!isNull _object && {!(_object isKindOf "Logic")}) then {
		_object setVariable [
			"zen_modules_intelParams",
			[_share, _delete, _actionType, _actionText, _actionSounds, _duration, _title, _text],
			true
		];

		private _jipID = [
			"zen_modules_addIntelAction",
			[_object, _share, _delete, _actionType, _actionText, _actionSounds, _duration, _title, _diaryText]
		] call CBA_fnc_globalEventJIP;

		[_jipID, _object] call CBA_fnc_removeGlobalEventJIP;
	};
} forEach _objects;
