/*
 * Author: Moony
 * Module: Plays set of Ambient Animations on synced units with parameters from the module selection
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
    [_logic, "ambient"] call EFUNC(modules,previewAnimation3DEN);
    true
  };
} else {
  _this params [
  ["_logic", objNull,[objNull]],
	["_vehicle", [], [[]]],
  ["_activated",true ,[true]]
  ];
};

private _condition = _logic getVariable [QGVAR(ambientAnimationMPSelection), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP", 0]];
private _object = _logic getVariable [QGVAR(ambientAnimationMPSnapObject), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Snap_Object", ""]];
private _snapObject = objNull;
private _allowDamage = _logic getVariable [QGVAR(ambientAnimationMPDamage), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Damage", 0]];
private _delay = _logic getVariable [QGVAR(ambientAnimationMPDelay), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Delay", 0.5]];

private _conditionMove = ["STAND1","STAND2","STAND_U1","STAND_U2","STAND_U3","WATCH","WATCH2","GUARD","LISTEN_BRIEFING","LEAN_ON_TABLE","LEAN","SIT_AT_TABLE","SIT1","SIT","SIT3","SIT_U1","SIT_U2","SIT_U3","SIT_HIGH1","SIT_HIGH","SIT_LOW","SIT_LOW_U","SIT_SAD1","SIT_SAD2","KNEEL","REPAIR_VEH_PRONE","REPAIR_VEH_KNEEL","REPAIR_VEH_STAND","PRONE_INJURED_U1","PRONE_INJURED_U2","PRONE_INJURED","KNEEL_TREAT","KNEEL_TREAT2","BRIEFING","BRIEFING_POINT_LEFT","BRIEFING_POINT_RIGHT","BRIEFING_POINT_TABLE"];

_condition = _condition max 0;
_condition = _condition min ((count _conditionMove) - 1);
private _conditionSelected = _conditionMove select _condition;

if (_activated) then {
  if (_object != "") then {
    _snapObject = missionNamespace getVariable [_object, objNull];
  };

  {
    [_x, _conditionSelected, _snapObject, _allowDamage, _delay max 0] spawn {
      params ["_unit", "_animationSet", "_snapObject", "_allowDamage", "_delay"];

      if (_delay > 0) then {
        sleep (random _delay);
      };

      [_unit, _animationSet, _snapObject, _allowDamage] call EFUNC(modules,applyAmbientAnimation);
    };
  } forEach _vehicle;
};

true
