/*
 * Author: Moony
 * Opens a ZEN dialog to set player respawn time.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, player] call mmm_modules_fnc_respawnTimer
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

private _defaultTime = missionNamespace getVariable [QGVAR(respawnTimerDefault), 120];
private _maxTime = missionNamespace getVariable [QGVAR(respawnTimerMax), 300];
_maxTime = 1 max _maxTime;
_defaultTime = (_defaultTime max 1) min _maxTime;

private _isPlayerTarget = !isNull _objectUnderCursor && {isPlayer _objectUnderCursor};
private _commonControls = [
	[
		"SLIDER",
		[
			"Respawn Time",
			"Sets the respawn time to the chosen value in seconds."
		],
		[
			1,
			_maxTime,
			_defaultTime,
			0
		]
	],
	[
		"CHECKBOX",
		[
			"Keep after respawn",
			"Reapply this timer after future respawns. If disabled, the timer only affects the current respawn instance."
		],
		false,
		false
	]
];

if (_isPlayerTarget) exitWith {
	[
		"Set Respawn Time",
		_commonControls,
		{
			params ["_dialogValues", "_objectUnderCursor"];
			_dialogValues params ["_time", "_remember"];

			[round _time, _remember] remoteExecCall [QFUNC(respawnTimerApplyLocal), _objectUnderCursor];

			private _text = format ["RESPAWN TIME FOR %1 SET TO %2 SECONDS", name _objectUnderCursor, round _time];
			if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
				diag_log format ["[%1] Respawn timer for %2 set to %3 seconds. Keep after respawn: %4", QADDON, _objectUnderCursor, round _time, _remember];
			};

			[objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
		},
		{},
		_objectUnderCursor
	] call zen_dialog_fnc_create;
};

[
	"Set Respawn Time",
	[
		[
			"OWNERS",
			[
				"Targets",
				"Select sides, groups, or players that should receive the respawn timer. Leave everything empty to affect all players."
			],
			[
				[west, east, resistance, civilian],
				[],
				[],
				0
			],
			false
		]
	] + _commonControls,
	{
		params ["_dialogValues"];
		_dialogValues params ["_owners", "_time", "_remember"];
		_owners params [
			["_selectedSides", [], [[]]],
			["_selectedGroups", [], [[]]],
			["_selectedPlayers", [], [[]]]
		];

		private _targets = allPlayers select {
			private _unit = _x;
			(
				_selectedSides isEqualTo []
				&& {_selectedGroups isEqualTo []}
				&& {_selectedPlayers isEqualTo []}
			)
			|| {side group _unit in _selectedSides}
			|| {group _unit in _selectedGroups}
			|| {_unit in _selectedPlayers}
		};

		_targets = _targets arrayIntersect _targets;

		{
			[round _time, _remember] remoteExecCall [QFUNC(respawnTimerApplyLocal), _x];
		} forEach _targets;

		private _text = format ["RESPAWN TIME SET TO %1 SECONDS FOR %2 PLAYER%3", round _time, count _targets, ["S", ""] select ((count _targets) isEqualTo 1)];
		if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
			diag_log format ["[%1] Respawn timer set to %2 seconds for %3 players. Keep after respawn: %4", QADDON, round _time, count _targets, _remember];
		};

		[objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{},
	[]
] call zen_dialog_fnc_create;
