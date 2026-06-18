/*
 * Author: Moony
 * Applies a playMove animation to a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Animation <STRING>
 * 2: Allow Damage <NUMBER>
 * 3: Editor Preview <BOOL>
 * 4: Visual Only <BOOL>
 * 5: Broadcast Visual <BOOL>
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
  ["_preview", false, [false]],
  ["_visualOnly", false, [false]],
  ["_broadcastVisual", true, [true]]
];

if (isNull _unit || {_animation isEqualTo ""} || {!(_unit isKindOf "CAManBase")}) exitWith {};

if (!_preview && {!_visualOnly} && _broadcastVisual) then {
  [_unit, _animation, _allowDamage, false, true, false] remoteExecCall [QEFUNC(modules,applyPlayMoveAnimation), 0, _unit];
};

if (!_visualOnly && {!local _unit}) exitWith {
  [_unit, _animation, _allowDamage, _preview, false, false] remoteExecCall [QEFUNC(modules,applyPlayMoveAnimation), _unit];
};

private _dir = getDir _unit;
private _posATL = getPosATL _unit;

if (_visualOnly) then {
  _unit playMoveNow _animation;
} else {
  if (_preview) then {
    _unit enableSimulation true;
    _unit enableAI "ANIM";
    _unit playMoveNow _animation;
  } else {
    _unit playMove _animation;
  };
};

_unit setDir _dir;
_unit setPosATL _posATL;

if (!_preview && {!_visualOnly} && {_allowDamage == 0}) then {
  _unit allowDamage false;
};

if (!_preview && {!_visualOnly}) then {
  _unit disableAI "ALL";
  _unit setBehaviour "CARELESS";
};
