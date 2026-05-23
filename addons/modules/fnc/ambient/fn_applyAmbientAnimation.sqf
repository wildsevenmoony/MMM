/*
 * Author: Moony
 * Applies a BIS ambient animation on the unit's owner.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Animation Set <STRING>
 * 2: Snap Object <OBJECT>
 * 3: Allow Damage <NUMBER>
 * 4: Editor Preview <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_animationSet", "", [""]],
  ["_snapObject", objNull, [objNull]],
  ["_allowDamage", 0, [0]],
  ["_preview", false, [false]]
];

if (isNull _unit || {_animationSet isEqualTo ""} || {!(_unit isKindOf "CAManBase")}) exitWith {};

if (!local _unit) exitWith {
  _this remoteExecCall [QEFUNC(modules,applyAmbientAnimation), _unit];
};

private _dir = getDir _unit;
private _posATL = getPosATL _unit;
private _edenPosition = [];
private _edenRotation = [];

if (_preview) then {
  _edenPosition = (_unit get3DENAttribute "position") param [0, []];
  _edenRotation = (_unit get3DENAttribute "rotation") param [0, []];
};

_unit call BIS_fnc_ambientAnim__terminate;
_unit switchMove "";

if (isNull _snapObject) then {
  [_unit, _animationSet, "ASIS"] call BIS_fnc_ambientAnim;
} else {
  [_unit, _animationSet, "ASIS", _snapObject] call BIS_fnc_ambientAnim;
};

if (_preview) then {
  _unit setVariable [QGVAR(animationPreview3DENRestoring), true];

  if (isNull _snapObject) then {
    if (_edenPosition isNotEqualTo []) then {
      if ((_unit distance _edenPosition) > 0.001) then {
        _unit set3DENAttribute ["position", _edenPosition];
      };
    } else {
      _unit setPosATL _posATL;
    };

    if (_edenRotation isNotEqualTo []) then {
      if ((abs ((getDir _unit) - (_edenRotation param [2, getDir _unit]))) > 0.01) then {
        _unit set3DENAttribute ["rotation", _edenRotation];
      };
    } else {
      _unit setDir _dir;
    };
  } else {
    private _snapRotation = +_edenRotation;
    if ((count _snapRotation) < 3) then {
      _snapRotation = [0, 0, getDir _unit];
    } else {
      _snapRotation set [2, getDir _unit];
    };

    _unit set3DENAttribute ["position", getPosATL _unit];
    _unit set3DENAttribute ["rotation", _snapRotation];
  };

  _unit setVariable [QGVAR(animationPreview3DENRestoring), false];

  [_unit, _snapObject, _edenPosition, _edenRotation, _posATL, _dir] spawn {
    params ["_unit", "_snapObject", "_edenPosition", "_edenRotation", "_posATL", "_dir"];

    uiSleep 0.05;
    if (isNull _unit) exitWith {};

    _unit setVariable [QGVAR(animationPreview3DENRestoring), true];

    if (isNull _snapObject) then {
      if (_edenPosition isNotEqualTo []) then {
        if ((_unit distance _edenPosition) > 0.001) then {
          _unit set3DENAttribute ["position", _edenPosition];
        };
      } else {
        _unit setPosATL _posATL;
      };

      if (_edenRotation isNotEqualTo []) then {
        if ((abs ((getDir _unit) - (_edenRotation param [2, getDir _unit]))) > 0.01) then {
          _unit set3DENAttribute ["rotation", _edenRotation];
        };
      } else {
        _unit setDir _dir;
      };
    } else {
      private _snapRotation = +_edenRotation;
      if ((count _snapRotation) < 3) then {
        _snapRotation = [0, 0, getDir _unit];
      } else {
        _snapRotation set [2, getDir _unit];
      };

      _unit set3DENAttribute ["position", getPosATL _unit];
      _unit set3DENAttribute ["rotation", _snapRotation];
    };

    _unit setVariable [QGVAR(animationPreview3DENRestoring), false];
  };
} else {
  if (isNull _snapObject) then {
    _unit setDir _dir;
    _unit setPosATL _posATL;
  };
};

if (!_preview && {_allowDamage == 0}) then {
  _unit allowDamage false;
};
