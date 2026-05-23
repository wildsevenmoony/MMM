/*
 * Author: Moony
 * Refreshes animation previews when synced Eden units are moved or rotated.
 *
 * Arguments:
 * 0: Edited Entity <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

if (!is3DEN) exitWith {};

private _entity = objNull;
if (_this isEqualType objNull) then {
  _entity = _this;
};

if (_this isEqualType []) then {
  {
    if (_x isEqualType objNull) exitWith {
      _entity = _x;
    };
  } forEach _this;
};

if (isNull _entity) exitWith {
  private _entities = [];
  {
    if (_x isEqualType []) then {
      {
        if (_x isEqualType objNull) then {
          _entities pushBackUnique _x;
        };
      } forEach _x;
    };
  } forEach all3DENEntities;

  {
    switch (typeOf _x) do {
      case QGVAR(ambientAnimationMP): {
        [_x, "ambient"] call EFUNC(modules,previewAnimation3DEN);
      };
      case QGVAR(animation): {
        [_x, "switchMove"] call EFUNC(modules,previewAnimation3DEN);
      };
      case QGVAR(playMoveAnimation): {
        [_x, "playMove"] call EFUNC(modules,previewAnimation3DEN);
      };
    };
  } forEach (_entities select {typeOf _x in [QGVAR(ambientAnimationMP), QGVAR(animation), QGVAR(playMoveAnimation)]});
};

if (typeOf _entity in [QGVAR(ambientAnimationMP), QGVAR(animation), QGVAR(playMoveAnimation)]) exitWith {
  switch (typeOf _entity) do {
    case QGVAR(ambientAnimationMP): {
      [_entity, "ambient"] call EFUNC(modules,previewAnimation3DEN);
    };
    case QGVAR(animation): {
      [_entity, "switchMove"] call EFUNC(modules,previewAnimation3DEN);
    };
    case QGVAR(playMoveAnimation): {
      [_entity, "playMove"] call EFUNC(modules,previewAnimation3DEN);
    };
  };
};

if (!(_entity isKindOf "CAManBase")) exitWith {
  private _entityName = (_entity get3DENAttribute "name") param [0, ""];
  private _entities = [];
  {
    if (_x isEqualType []) then {
      {
        if (_x isEqualType objNull) then {
          _entities pushBackUnique _x;
        };
      } forEach _x;
    };
  } forEach all3DENEntities;

  {
    private _objectName = _x getVariable [QGVAR(ambientAnimationMPSnapObject), _x getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Snap_Object", ""]];
    private _snapObject = objNull;

    if (_objectName != "") then {
      _snapObject = missionNamespace getVariable [_objectName, objNull];
      if (isNull _snapObject && {_entityName isEqualTo _objectName}) then {
        _snapObject = _entity;
      };
    };

    if (_snapObject isEqualTo _entity) then {
      [_x, "ambient"] call EFUNC(modules,previewAnimation3DEN);
    };
  } forEach (_entities select {typeOf _x isEqualTo QGVAR(ambientAnimationMP)});
};

if (_entity getVariable [QGVAR(animationPreview3DENRestoring), false]) exitWith {};

private _lastRefresh = _entity getVariable [QGVAR(animationPreview3DENLastRefresh), 0];
if ((diag_tickTime - _lastRefresh) < 0.05) exitWith {};
_entity setVariable [QGVAR(animationPreview3DENLastRefresh), diag_tickTime];

private _modules = [];
{
  if (_x isEqualType objNull) then {
    _modules pushBackUnique _x;
  };

  if (_x isEqualType []) then {
    {
      if (_x isEqualType objNull) then {
        _modules pushBackUnique _x;
      };
    } forEach _x;
  };
} forEach (get3DENConnections _entity);

_modules = _modules select {typeOf _x in [QGVAR(ambientAnimationMP), QGVAR(animation), QGVAR(playMoveAnimation)]};

{
  switch (typeOf _x) do {
    case QGVAR(ambientAnimationMP): {
      [_x, "ambient"] call EFUNC(modules,previewAnimation3DEN);
    };
    case QGVAR(animation): {
      [_x, "switchMove"] call EFUNC(modules,previewAnimation3DEN);
    };
    case QGVAR(playMoveAnimation): {
      [_x, "playMove"] call EFUNC(modules,previewAnimation3DEN);
    };
  };
} forEach _modules;
