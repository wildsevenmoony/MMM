params [
  ["_logic", objNull,[objNull]],
	["_vehicle", [], [[]]],
  ["_activated",true ,[true]]
];

private _condition = _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP", 0];
private _object = _logic getVariable "MMM_MODULES_Module_AmbientAnimationMP_Snap_Object";
private _snapObject = call compile _object;
private _allowDamage = _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Damage", 0];

private _conditionMove = ["STAND1","STAND2","STAND_U1","STAND_U2","STAND_U3","WATCH","WATCH2","GUARD","LISTEN_BRIEFING","LEAN_ON_TABLE","LEAN","SIT_AT_TABLE","SIT1","SIT","SIT3","SIT_U1","SIT_U2","SIT_U3","SIT_HIGH1","SIT_HIGH","SIT_LOW","SIT_LOW_U","SIT_SAD1","SIT_SAD2","KNEEL","REPAIR_VEH_PRONE","REPAIR_VEH_KNEEL","REPAIR_VEH_STAND","PRONE_INJURED_U1","PRONE_INJURED_U2","PRONE_INJURED","KNEEL_TREAT","KNEEL_TREAT2","BRIEFING","BRIEFING_POINT_LEFT","BRIEFING_POINT_RIGHT","BRIEFING_POINT_TABLE"];

private _conditionSelected = _conditionMove select _condition;

//Run Code only on the server


if (_activated) then {
  //Run Code only on the server
  if (local (_vehicle select 0)) then {
    switch (isNil _object) do {
      case true: {
        {
          [_x, _conditionSelected,"ASIS"] call BIS_fnc_ambientAnim;
          switch (_allowDamage) do {
            case 0: {[_x, false] remoteExec ["allowdamage", 0];};
            case 1: {[_x, false] remoteExec ["allowdamage", 1];};
          };
        } forEach _vehicle;
      };
      case false: {
        {
          [_x, _conditionSelected,"ASIS",_snapObject] call BIS_fnc_ambientAnim;
          switch (_allowDamage) do {
            case 0: {[_x, false] remoteExec ["allowdamage", 0];};
            case 1: {[_x, false] remoteExec ["allowdamage", 1];};
          };
        } forEach _vehicle;
      };
    };
  };
};