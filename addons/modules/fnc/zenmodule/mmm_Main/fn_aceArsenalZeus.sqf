/*
 * Author: Moony
 * Adds or updates an ACE Arsenal on the object under the Zeus cursor.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_aceArsenalZeus
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullObject.hpp"

private _defaultScrollAction = _objectUnderCursor getVariable [QGVAR(aceArsenalScrollAction), false];
private _defaultBlacklist = _objectUnderCursor getVariable [QGVAR(aceArsenalBlacklist), ""];
private _defaultLimited = _objectUnderCursor getVariable [QGVAR(aceArsenalLimited), false];
private _defaultLimitedItems = _objectUnderCursor getVariable [QGVAR(aceArsenalLimitedItems), ""];
private _defaultCompatibleMagazines = _objectUnderCursor getVariable [QGVAR(aceArsenalAddCompatibleMagazines), false];
private _defaultCompatibleAttachments = _objectUnderCursor getVariable [QGVAR(aceArsenalAddCompatibleAttachments), false];

[
	"Add ACE Arsenal",
	[
		[
			"CHECKBOX",
			["Add Scroll Action", "Also adds a normal scroll wheel action for opening the arsenal."],
			_defaultScrollAction,
			false
		],
		[
			"EDIT",
			["Blacklist", "Comma-separated item class names that are removed from the arsenal."],
			_defaultBlacklist,
			false
		],
		[
			"CHECKBOX",
			["Limited Arsenal", "Remove all items first and only add the class names from Limited Arsenal Items."],
			_defaultLimited,
			false
		],
		[
			"EDIT",
			["Limited Arsenal Items", "Comma-separated item class names used when Limited Arsenal is enabled."],
			_defaultLimitedItems,
			false
		],
		[
			"CHECKBOX",
			["Add Compatible Magazines", "Adds all compatible magazines for weapons listed in Limited Arsenal Items."],
			_defaultCompatibleMagazines,
			false
		],
		[
			"CHECKBOX",
			["Add Compatible Attachments", "Adds all compatible attachments for weapons listed in Limited Arsenal Items."],
			_defaultCompatibleAttachments,
			false
		]
	],
	{
		params ["_dialogValues", "_objectUnderCursor"];
		_dialogValues params [
			"_addScrollAction",
			"_blacklist",
			"_limited",
			"_limitedItems",
			"_addCompatibleMagazines",
			"_addCompatibleAttachments"
		];

		private _wasExisting = _objectUnderCursor getVariable [QGVAR(aceArsenalInitialized), false];
		[
			_objectUnderCursor,
			_addScrollAction,
			_blacklist,
			_limited,
			_limitedItems,
			_addCompatibleMagazines,
			_addCompatibleAttachments
		] remoteExecCall [QEFUNC(modules,aceArsenal), 2];

		private _text = ["ACE ARSENAL ADDED", "ACE ARSENAL UPDATED"] select _wasExisting;
		[objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{},
	_objectUnderCursor
] call zen_dialog_fnc_create;
