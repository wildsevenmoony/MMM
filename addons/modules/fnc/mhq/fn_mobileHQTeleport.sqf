/*
 * Author: Moony
 * Teleports a player to a selected MHQ.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Destination MHQ <OBJECT>
 *
 * Return Value:
 * Teleport succeeded <BOOL>
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
    ["_player", objNull, [objNull]],
    ["_destination", objNull, [objNull]]
];

if (!hasInterface || {isNull _player} || {isNull _destination}) exitWith {false};
if (!alive _player || {!alive _destination}) exitWith {false};
if !(_destination getVariable [QGVAR(mhqDeployed), false]) exitWith {false};

[_player, _destination, true] call EFUNC(modules,mobileHQCanTeleportTo) params ["_canTeleport", "_reason"];
if (!_canTeleport) exitWith {
    [_reason, 2, _player, 12] call ace_common_fnc_displayTextStructured;
    false
};

[_player, _destination] spawn {
    params ["_player", "_destination"];

    private _destinationName = _destination getVariable [QGVAR(mhqName), "Mobile HQ"];
    private _message = format ["Teleporting to %1", _destinationName];

    cutText ["", "BLACK OUT", 3];
    [_message] spawn {
        params ["_message"];

        private _text = "";
        for "_i" from 0 to ((count _message) - 1) do {
            _text = _text + (_message select [_i, 1]);
            titleText [_text, "PLAIN DOWN", 0];
            sleep 0.04;
        };

        sleep 4;
        titleFadeOut 0.5;
    };

    disableUserInput true;
    sleep 3;

    [_player, _destination, true] call EFUNC(modules,mobileHQCanTeleportTo) params ["_canTeleport", "_reason"];
    if (!_canTeleport) exitWith {
        disableUserInput false;
        cutText ["", "BLACK IN", 0.5];
        titleFadeOut 0.1;
        [_reason, 2, _player, 12] call ace_common_fnc_displayTextStructured;
    };

    if (vehicle _player isNotEqualTo _player) then {
        moveOut _player;
    };

    if (_destination isKindOf "CAManBase" && {vehicle _destination isNotEqualTo _destination}) then {
        private _vehicle = vehicle _destination;
        private _movedIn = _player moveInAny _vehicle;
        if (!_movedIn) exitWith {
            disableUserInput false;
            cutText ["", "BLACK IN", 0.5];
            titleFadeOut 0.1;
            ["No free seat is available in the MHQ vehicle.", 2, _player, 12] call ace_common_fnc_displayTextStructured;
        };
    } else {
        private _angle = random 360;
        private _position = _destination getPos [5, _angle];
        _player setVehiclePosition [_position, [], 5, "NONE"];
    };

    sleep 2;
    disableUserInput false;
    cutText ["", "BLACK IN", 3];
};

true
