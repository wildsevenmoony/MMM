/*
 * Author: Moony
 * Previews animation modules directly in Eden.
 *
 * Arguments:
 * 0: Logic Object <OBJECT>
 * 1: Mode <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
  ["_logic", objNull, [objNull]],
  ["_mode", "", [""]]
];

if (!is3DEN || {isNull _logic}) exitWith {};

private _units = synchronizedObjects _logic select {_x isKindOf "CAManBase"};
if (_units isEqualTo []) then {
  {
    if (_x isEqualType objNull) then {
      _units pushBackUnique _x;
    };

    if (_x isEqualType []) then {
      {
        if (_x isEqualType objNull) then {
          _units pushBackUnique _x;
        };
      } forEach _x;
    };
  } forEach (get3DENConnections _logic);

  _units = _units select {_x isKindOf "CAManBase"};
};

if (_units isEqualTo []) exitWith {};

private _previewEnabledRaw = (_logic get3DENAttribute QGVAR(animationPreview3DEN)) param [0, _logic getVariable [QGVAR(animationPreview3DEN), true]];
private _previewEnabled = true;

switch (typeName _previewEnabledRaw) do {
  case "BOOL": {
    _previewEnabled = _previewEnabledRaw;
  };
  case "SCALAR": {
    _previewEnabled = _previewEnabledRaw > 0;
  };
  case "STRING": {
    private _previewEnabledString = toLower _previewEnabledRaw;
    _previewEnabled = _previewEnabledString in ["1", "true", "yes"];
  };
};

if (!_previewEnabled) exitWith {
  {
    _x call BIS_fnc_ambientAnim__terminate;
    _x switchMove "";
  } forEach _units;
};

switch (_mode) do {
  case "ambient": {
    private _index = (_logic get3DENAttribute QGVAR(ambientAnimationMPSelectionCombo)) param [0, _logic getVariable [QGVAR(ambientAnimationMPSelection), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP", 0]]];
    private _objectName = (_logic get3DENAttribute QGVAR(ambientAnimationMPSnapObjectEdit)) param [0, _logic getVariable [QGVAR(ambientAnimationMPSnapObject), _logic getVariable ["MMM_MODULES_Module_AmbientAnimationMP_Snap_Object", ""]]];
    private _animationSets = ["STAND1","STAND2","STAND_U1","STAND_U2","STAND_U3","WATCH","WATCH2","GUARD","LISTEN_BRIEFING","LEAN_ON_TABLE","LEAN","SIT_AT_TABLE","SIT1","SIT","SIT3","SIT_U1","SIT_U2","SIT_U3","SIT_HIGH1","SIT_HIGH","SIT_LOW","SIT_LOW_U","SIT_SAD1","SIT_SAD2","KNEEL","REPAIR_VEH_PRONE","REPAIR_VEH_KNEEL","REPAIR_VEH_STAND","PRONE_INJURED_U1","PRONE_INJURED_U2","PRONE_INJURED","KNEEL_TREAT","KNEEL_TREAT2","BRIEFING","BRIEFING_POINT_LEFT","BRIEFING_POINT_RIGHT","BRIEFING_POINT_TABLE"];

    _index = _index max 0;
    _index = _index min ((count _animationSets) - 1);

    private _snapObject = objNull;
    if (_objectName != "") then {
      _snapObject = missionNamespace getVariable [_objectName, objNull];
      if (isNull _snapObject) then {
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
          if (((_x get3DENAttribute "name") param [0, ""]) isEqualTo _objectName) exitWith {
            _snapObject = _x;
          };
        } forEach _entities;
      };
    };

    {
      [_x, _animationSets select _index, _snapObject, 1, true] call EFUNC(modules,applyAmbientAnimation);
    } forEach _units;
  };
  case "switchMove": {
    private _index = (_logic get3DENAttribute QGVAR(animationSelectionCombo)) param [0, _logic getVariable [QGVAR(animationSelection), _logic getVariable ["MMM_MODULES_Module_Animation_Animations", 0]]];
    private _customAnimation = (_logic get3DENAttribute QGVAR(animationCustomEdit)) param [0, _logic getVariable [QGVAR(animationCustom), _logic getVariable ["MMM_MODULES_Module_Animation_Custom", ""]]];
    private _animations = ["Acts_CivilIdle_1","Acts_CivilIdle_2","Acts_CivilListening_1","Acts_CivilListening_2","Acts_EpicSplit_in","Acts_millerCamp_A","Acts_millerCamp_C","acts_millerIdle","Acts_CivilTalking_1","Acts_CivilTalking_2","Acts_Kore_TalkingOverRadio_loop","Acts_listeningToRadio_Loop","Acts_StandingSpeakingUnarmed","Acts_AidlPsitMstpSsurWnonDnon01","Acts_AidlPsitMstpSsurWnonDnon02","Acts_AidlPsitMstpSsurWnonDnon03","Acts_AidlPsitMstpSsurWnonDnon04","Acts_AidlPsitMstpSsurWnonDnon05","Acts_ExecutionVictim_Loop","Acts_CivilShocked_1","Acts_CivilShocked_2","Acts_CivilHiding_1","Acts_CivilHiding_2","Acts_LyingWounded_loop1","Acts_LyingWounded_loop2","Acts_LyingWounded_loop3","Acts_CivilInjuredGeneral_1","Acts_CivilInjuredArms_1","Acts_CivilInjuredChest_1","Acts_CivilInjuredHead_1","Acts_CivilInjuredLegs_1","Acts_CivilInjuredArms_1","Acts_CivilInjuredChest_1","Acts_CivilInjuredHead_1","Acts_CivilInjuredLegs_1","Acts_InjuredAngryRifle01","Acts_InjuredCoughRifle02","Acts_InjuredLookingRifle01","Acts_InjuredLookingRifle02","Acts_InjuredLookingRifle03","Acts_InjuredLookingRifle04","Acts_InjuredLookingRifle05","Acts_InjuredLyingRifle01","Acts_InjuredLyingRifle02","Acts_InjuredLyingRifle02_180","Acts_InjuredSpeakingRifle01","Acts_SittingWounded_breath","Acts_SittingWounded_loop","Acts_ExecutionVictim_KillTerminal","Acts_Onchair_Dead","acts_millerDisarming_deskLoop","acts_millerDisarming_deskCrouch_loop"];

    _index = _index max 0;
    _index = _index min ((count _animations) - 1);
    private _animation = _animations select _index;
    private _customAnimationSelected = [_customAnimation] call EFUNC(modules,parseCustomAnimation);

    if (_customAnimationSelected != "") then {
      _animation = _customAnimationSelected;
    };

    {
      [_x, _animation, 1, true] call EFUNC(modules,applySwitchMoveAnimation);
    } forEach _units;
  };
  case "playMove": {
    private _index = (_logic get3DENAttribute QGVAR(playMoveAnimationSelectionCombo)) param [0, _logic getVariable [QGVAR(playMoveAnimationSelection), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Animations", 0]]];
    private _customAnimation = (_logic get3DENAttribute QGVAR(playMoveAnimationCustomEdit)) param [0, _logic getVariable [QGVAR(playMoveAnimationCustom), _logic getVariable ["MMM_MODULES_Module_PlayMoveAnimation_Custom", ""]]];
    private _animations = [
      "AmovPercMstpSnonWnonDnon",
      "AmovPercMstpSnonWnonDnon_exercisePushup",
      "AmovPercMstpSnonWnonDnon_exerciseKata",
      "AmovPercMstpSnonWnonDnon_exerciseKneeBendA",
      "AmovPercMstpSnonWnonDnon_exerciseKneeBendB"
    ];

    _index = _index max 0;
    _index = _index min ((count _animations) - 1);
    private _animation = _animations select _index;
    private _customAnimationSelected = [_customAnimation] call EFUNC(modules,parseCustomAnimation);

    if (_customAnimationSelected != "") then {
      _animation = _customAnimationSelected;
    };

    {
      [_x, _animation, 1, true] call EFUNC(modules,applyPlayMoveAnimation);
    } forEach _units;
  };
};
