/*
 * Author: Moony
 * Adds scroll menu actions to the unit (Medic). The actions heal either the player or all units in a radius of 10 meters around the "Medic". When the action is used a notification pops up on the screen.
 *
 * Arguments:
 * 0: AI <OBJECT>
 * 1: "Heal Player" action title <STRING>
 * 2: "Heal all in 10 meter radius" action title <STRING>
 * 3: Condition for the action to show <BOOL|CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [basemedic, "Suit yourself", "Help them out", {!Alive otherbasemedic}] call mmm_modules_fnc_baseMedic
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_medic", objNull, [objNull]],
	["_text", "Heal me", [""]],
	["_text2", "Heal everyone", [""]],
	["_condition", "true", [""]]
];

if (!isServer || {_medic getVariable [QGVAR(baseMedic), false]}) exitWith {};

private _actionDistance = missionNamespace getVariable [QGVAR(baseMedicActionDistance), 3];
private _healRadius = missionNamespace getVariable [QGVAR(baseMedicHealRadius), 10];

if (missionNamespace getVariable [QGVAR(debugLogging), false]) then {
	diag_log format ["[%1] Adding base medic actions to %2 with action distance %3 and heal radius %4", QADDON, _medic, _actionDistance, _healRadius];
};

// Adds "Heal me"
[
	_medic,
	[
		(format ["<img size='1' shadow='1' image='\a3\ui_f\data\igui\cfg\Actions\heal_ca.paa'/> %1", _text]),
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			_caller call ace_medical_treatment_fnc_fullHealLocal;
			["mmm_notification_healed",[]] call bis_fnc_showNotification;
		},
		[],
		9,
		false,
		true,
		"",
		(
			format [
				"(_this distance _target < (missionNamespace getVariable ['%2', 3])) && {%1} && {!(_target isKindOf 'CAManBase') || {[_target] call ace_common_fnc_isAwake}}",
				_condition,
				QGVAR(baseMedicActionDistance)
			]
		)
	]
] remoteExec ["addAction", 0, true];

// Adds "Heal everyone"
[
	_medic,
	[
		(format ["<img size='1' shadow='1' image='\a3\ui_f\data\igui\cfg\Actions\heal_ca.paa'/> %1", _text2]),
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			private _healRadius = missionNamespace getVariable [QGVAR(baseMedicHealRadius), 10];
			private _radiusUnits = _target nearEntities ["Man", _healRadius];
			private _healedPlayers = allPlayers select {_x in _radiusUnits && {_x != _caller}};

			{
				[_x] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal", _x];
			} forEach _radiusUnits;

			// Notify the caller separately so they do not also get the "healed by someone" message.
			["mmm_notification_sombodyhealed", []] call bis_fnc_showNotification;
			["mmm_notification_healedbysomeone", []] remoteExecCall ["bis_fnc_showNotification", _healedPlayers];
		},
		[],
		8.5,
		false,
		true,
		"",
		(
			format [
				"(_this distance _target < (missionNamespace getVariable ['%2', 3])) && {%1} && {!(_target isKindOf 'CAManBase') || {[_target] call ace_common_fnc_isAwake}}",
				_condition,
				QGVAR(baseMedicActionDistance)
			]
		)
	]
] remoteExec ["addAction", 0, true];

[_medic, "mmm_Medic"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
_medic setVariable [QGVAR(baseMedic), true, true];
