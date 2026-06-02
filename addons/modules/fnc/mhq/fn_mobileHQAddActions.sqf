/*
 * Author: Moony
 * Adds local ACE interaction actions for MHQ deployment.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_mhq", objNull, [objNull]]
];

if (!hasInterface || {isNull _mhq} || {isNil "ace_interact_menu_fnc_createAction"}) exitWith {};
if (_mhq getVariable [QGVAR(mhqAceActionsAdded), false]) exitWith {};

private _deployAction = [
    QGVAR(mhqDeploy),
    "Deploy MHQ",
    "\a3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa",
    {
        params ["_target"];

        private _duration = missionNamespace getVariable [QGVAR(mhqDeployDuration), 5];
        if (_duration <= 0) exitWith {
            [_target, true] remoteExecCall [QEFUNC(modules,mobileHQSetDeployed), 2];
        };

        [
            _duration,
            [_target, true],
            {
                params ["_args"];
                _args params ["_target", "_deployed"];

                [_target, _deployed] remoteExecCall [QEFUNC(modules,mobileHQSetDeployed), 2];
            },
            {},
            "Deploying MHQ"
        ] call ace_common_fnc_progressBar;
    },
    {
        params ["_target"];
        alive _target
        && {missionNamespace getVariable [QGVAR(mhqEnableDeployment), true]}
        && {!(_target getVariable [QGVAR(mhqAlwaysDeployed), false])}
        && {!(_target getVariable [QGVAR(mhqDeployed), false])}
    },
    {}
] call ace_interact_menu_fnc_createAction;

private _undeployAction = [
    QGVAR(mhqUndeploy),
    "Undeploy MHQ",
    "\a3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa",
    {
        params ["_target"];

        private _duration = missionNamespace getVariable [QGVAR(mhqDeployDuration), 5];
        if (_duration <= 0) exitWith {
            [_target, false] remoteExecCall [QEFUNC(modules,mobileHQSetDeployed), 2];
        };

        [
            _duration,
            [_target, false],
            {
                params ["_args"];
                _args params ["_target", "_deployed"];

                [_target, _deployed] remoteExecCall [QEFUNC(modules,mobileHQSetDeployed), 2];
            },
            {},
            "Undeploying MHQ"
        ] call ace_common_fnc_progressBar;
    },
    {
        params ["_target"];
        alive _target
        && {missionNamespace getVariable [QGVAR(mhqEnableDeployment), true]}
        && {!(_target getVariable [QGVAR(mhqAlwaysDeployed), false])}
        && {_target getVariable [QGVAR(mhqDeployed), false]}
    },
    {}
] call ace_interact_menu_fnc_createAction;

private _teleportChildren = {
    params ["_target", "_player"];

    private _playerSide = side group _player;
    private _includeFriendly = missionNamespace getVariable [QGVAR(mhqTeleportIncludeFriendlySides), false];
    private _sideNames = createHashMapFromArray [
        [west, "BLUFOR"],
        [east, "OPFOR"],
        [independent, "IND"],
        [civilian, "CIV"],
        [sideEnemy, "ENEMY"],
        [sideUnknown, "UNKNOWN"]
    ];

    private _mhqs = (missionNamespace getVariable [QGVAR(mhqs), []]) select {
        !isNull _x
        && {alive _x}
        && {_x isNotEqualTo _target}
        && {_x getVariable [QGVAR(mhqDeployed), false]}
    };

    private _destinations = _mhqs select {
        private _mhqSide = call compile (_x getVariable [QGVAR(mhqSide), "west"]);
        (_mhqSide isEqualTo _playerSide) || {_includeFriendly && {_playerSide getFriend _mhqSide >= 0.6}}
    };

    _destinations apply {
        private _destination = _x;
        private _destinationSide = call compile (_destination getVariable [QGVAR(mhqSide), "west"]);
        private _name = _destination getVariable [QGVAR(mhqName), "Mobile HQ"];
        private _sideName = _sideNames getOrDefault [_destinationSide, str _destinationSide];
        private _displayName = format ["%1 [%2]", _name, _sideName];
        private _actionId = format [QGVAR(mhqTeleport_%1), netId _destination];
        private _statement = compile format [
            "params ['_target', '_player']; private _destination = objectFromNetId '%1'; [_player, _destination] call %2;",
            netId _destination,
            QEFUNC(modules,mobileHQTeleport)
        ];

        private _action = [
            _actionId,
            _displayName,
            "\a3\ui_f\data\igui\cfg\simpleTasks\types\move_ca.paa",
            _statement,
            {true}
        ] call ace_interact_menu_fnc_createAction;

        [_action, [], _target]
    }
};

private _teleportAction = [
    QGVAR(mhqTeleport),
    "Teleport to MHQ",
    "\a3\ui_f\data\igui\cfg\simpleTasks\types\move_ca.paa",
    {},
    {
        params ["_target", "_player"];

        alive _target
        && {alive _player}
        && {_target getVariable [QGVAR(mhqDeployed), false]}
        && {missionNamespace getVariable [QGVAR(mhqTeleportEnabled), false]}
    },
    _teleportChildren
] call ace_interact_menu_fnc_createAction;

[_mhq, 0, ["ACE_MainActions"], _deployAction] call ace_interact_menu_fnc_addActionToObject;
[_mhq, 0, ["ACE_MainActions"], _undeployAction] call ace_interact_menu_fnc_addActionToObject;
[_mhq, 0, ["ACE_MainActions"], _teleportAction] call ace_interact_menu_fnc_addActionToObject;

_mhq setVariable [QGVAR(mhqAceActionsAdded), true];
