/*
 * Author: Moony
 * Applies a playMove animation on the unit's owner.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Animation <STRING>
 * 2: Allow Damage <NUMBER>
 * 3: Editor Preview <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_animation", "", [""]],
  ["_allowDamage", 0, [0]],
  ["_preview", false, [false]]
];

if (isNull _unit || {_animation isEqualTo ""} || {!(_unit isKindOf "CAManBase")}) exitWith {};

if (!local _unit) exitWith {
  _this remoteExecCall [QEFUNC(modules,applyPlayMoveAnimation), _unit];
};

private _dir = getDir _unit;
private _posATL = getPosATL _unit;

if (_preview) then {
  _unit enableSimulation true;
  _unit enableAI "ANIM";
  _unit playMoveNow _animation;
} else {
  _unit playMove _animation;
};

_unit setDir _dir;
_unit setPosATL _posATL;

if (!_preview && {_allowDamage == 0}) then {
  _unit allowDamage false;
};

if (!_preview) then {
  _unit disableAI "ALL";
  _unit setBehaviour "CARELESS";
};
