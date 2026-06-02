/*
 * Author: Moony
 * Opens a ZEN dialog to set a player's respawn time.
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

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"

private _defaultTime = missionNamespace getVariable [QGVAR(respawnTimerDefault), 2];
private _maxTime = missionNamespace getVariable [QGVAR(respawnTimerMax), 120];
_maxTime = 1 max _maxTime;
_defaultTime = (_defaultTime max 1) min _maxTime;

// Dialog
[
	"Set Respawn Time",
	[
		[
			"SLIDER",
			[
				"Respawn Time",
				"Sets the Respawn time to the chosen value in seconds"
			],
			[
				1, // Min. Value
				_maxTime, // Max. Value
				_defaultTime, // Default Value
				0 // Number of Decimals
			]
		],
		[
			"CHECKBOX",
				[
					"Keep after respawn",
					"Should the time be kept after Respawn?"
				],
				false,
				false
		]
	],
	{
		params ["_dialogValues", "_objectUnderCursor"];
		_dialogValues params ["_time", "_remember"];

		[_time] remoteExec ["setPlayerRespawnTime", _objectUnderCursor];

		if (_remember) then {
			_objectUnderCursor setVariable [QGVAR(respawnTimer), _time, true];
			_objectUnderCursor addEventHandler ["Respawn", {
				params ["_unit", "_corpse"];
				private _respawnTimer = _unit getVariable QGVAR(respawnTimer);

				if !(_unit isNil QGVAR(respawnTimer)) then {
					[_respawnTimer] remoteExec ["setPlayerRespawnTime", _unit];
				};

			}];
		};

		private _text = format ["PLAYERS RESPAWN TIME HAS BEEN SET TO %1 SECONDS", _time];
		if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
			diag_log format ["[%1] Respawn timer for %2 set to %3 seconds. Keep after respawn: %4", QADDON, _objectUnderCursor, _time, _remember];
		};
		[objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{},
	_objectUnderCursor
] call zen_dialog_fnc_create;
	
