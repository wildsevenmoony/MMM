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
				120, // Max. Value
				2, // Default Value
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
		[objNull, _text] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{},
	_objectUnderCursor
] call zen_dialog_fnc_create;
	
