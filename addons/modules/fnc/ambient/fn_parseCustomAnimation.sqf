/*
 * Author: Moony
 * Normalizes a custom animation override.
 *
 * Arguments:
 * 0: Raw Animation Input <STRING>
 *
 * Return Value:
 * Animation Name <STRING>
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
  ["_rawInput", "", [""]]
];

private _parts = _rawInput splitString ",";
private _animation = "";

{
  private _part = trim _x;
  _part = _part trim ["'""", 0];
  _part = _part trim ["'""", 2];

  if (_part != "") exitWith {
    _animation = _part;
  };
} forEach _parts;

_animation
