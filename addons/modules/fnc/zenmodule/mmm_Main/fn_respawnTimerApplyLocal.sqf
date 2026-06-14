/*
 * Author: Moony
 * Applies a respawn timer to the local player and optionally reapplies it after respawn.
 *
 * Arguments:
 * 0: Respawn time in seconds <NUMBER>
 * 1: Keep this respawn timer after future respawns <BOOL>
 *
 * Return Value:
 * Timer was applied <BOOL>
 *
 * Example:
 * [10, true] call mmm_modules_fnc_respawnTimerApplyLocal
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_time", 2, [0]],
	["_persistent", false, [false]]
];

if (!hasInterface || {isNull player}) exitWith {false};

_time = 1 max (round _time);

setPlayerRespawnTime _time;

private _eventHandler = player getVariable [QGVAR(respawnTimerEventHandler), -1];

if (_persistent) then {
	player setVariable [QGVAR(respawnTimer), _time, false];

	if (_eventHandler < 0) then {
		_eventHandler = player addEventHandler ["Respawn", {
			params ["_unit"];

			private _respawnTimer = _unit getVariable [QGVAR(respawnTimer), -1];
			if (_respawnTimer >= 1) then {
				setPlayerRespawnTime _respawnTimer;
			};
		}];

		player setVariable [QGVAR(respawnTimerEventHandler), _eventHandler, false];
	};
} else {
	player setVariable [QGVAR(respawnTimer), nil, false];

	if (_eventHandler >= 0) then {
		player removeEventHandler ["Respawn", _eventHandler];
		player setVariable [QGVAR(respawnTimerEventHandler), nil, false];
	};
};

true
