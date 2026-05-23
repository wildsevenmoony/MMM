/*
 * Author: Moony
 * Module: Plays a playMove animation on synced units with parameters from the module selection.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Affected Object <ARRAY>
 * 2: Active <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

private _logic = objNull;
private _vehicle = [];
private _activated = true;

if ((_this param [0, objNull]) isEqualType "") then {
  private _mode = _this param [0, "", [""]];
  private _input = _this param [1, [], [[]]];

  if (_mode != "init" && {!(_mode in ["attributesChanged3DEN", "registeredToWorld3DEN", "connectionChanged3DEN"])}) exitWith {true};

  _input params [
    ["_logicInput", objNull, [objNull]],
    ["_activatedInput", true, [true]]
  ];

  _logic = _logicInput;
  _activated = _activatedInput;
  _vehicle = synchronizedObjects _logic;

  if (is3DEN) exitWith {
    [_logic, "playMove"] call EFUNC(modules,previewAnimation3DEN);
    true
  };
} else {
  _this params [
    ["_logic", objNull,[objNull]],
    ["_vehicle", [], [[]]],
    ["_activated",true ,[true]]
  ];
};

private _condition = _logic getVariable [QGVAR(playMoveAnimationSelection), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Animations", 0]];
private _customAnimation = _logic getVariable [QGVAR(playMoveAnimationCustom), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Custom", ""]];
private _allowDamage = _logic getVariable [QGVAR(playMoveAnimationDamage), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Damage", 0]];
private _delay = _logic getVariable [QGVAR(playMoveAnimationDelay), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Delay", 0.5]];

private _animations = [
  "AmovPercMstpSnonWnonDnon",
  "AmovPercMstpSnonWnonDnon_exercisePushup",
  "AmovPercMstpSnonWnonDnon_exerciseKata",
  "AmovPercMstpSnonWnonDnon_exerciseKneeBendA",
  "AmovPercMstpSnonWnonDnon_exerciseKneeBendB"
];

_condition = _condition max 0;
_condition = _condition min ((count _animations) - 1);
private _animationSelected = _animations select _condition;
private _customAnimationSelected = [_customAnimation] call EFUNC(modules,parseCustomAnimation);

if (_customAnimationSelected != "") then {
  _animationSelected = _customAnimationSelected;
};

if (_activated) then {
  {
    [_x, _animationSelected, _allowDamage, _delay max 0] spawn {
      params ["_unit", "_animation", "_allowDamage", "_delay"];

      if (_delay > 0) then {
        sleep (random _delay);
      };

      [_unit, _animation, _allowDamage] call EFUNC(modules,applyPlayMoveAnimation);
    };
  } forEach _vehicle;
};

true
