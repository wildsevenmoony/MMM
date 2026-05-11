/*
 * Author: Moony
 * Module: Plays an Animations on synced units with parameters from the module selection
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

params [
  ["_logic", objNull,[objNull]],
	["_vehicle", [], [[]]],
  ["_activated",true ,[true]]
];

private _condition = _logic getVariable [QGVAR(animationSelection), _logic getVariable ["MMM_MODULES_Module_Animation_Animations", 0]];
private _allowDamage = _logic getVariable [QGVAR(animationDamage), _logic getVariable ["MMM_MODULES_Module_Animation_Damage", 0]];

private _act = ["Acts_CivilIdle_1","Acts_CivilIdle_2","Acts_CivilListening_1","Acts_CivilListening_2","Acts_EpicSplit_in","Acts_millerCamp_A","Acts_millerCamp_C","acts_millerIdle","Acts_CivilTalking_1","Acts_CivilTalking_2","Acts_Kore_TalkingOverRadio_loop","Acts_listeningToRadio_Loop","Acts_StandingSpeakingUnarmed","Acts_AidlPsitMstpSsurWnonDnon01","Acts_AidlPsitMstpSsurWnonDnon02","Acts_AidlPsitMstpSsurWnonDnon03","Acts_AidlPsitMstpSsurWnonDnon04","Acts_AidlPsitMstpSsurWnonDnon05","Acts_ExecutionVictim_Loop","Acts_CivilShocked_1","Acts_CivilShocked_2","Acts_CivilHiding_1","Acts_CivilHiding_2","Acts_LyingWounded_loop1","Acts_LyingWounded_loop2","Acts_LyingWounded_loop3","Acts_CivilInjuredGeneral_1","Acts_CivilInjuredArms_1","Acts_CivilInjuredChest_1","Acts_CivilInjuredHead_1","Acts_CivilInjuredLegs_1","Acts_CivilInjuredArms_1","Acts_CivilInjuredChest_1","Acts_CivilInjuredHead_1","Acts_CivilInjuredLegs_1","Acts_InjuredAngryRifle01","Acts_InjuredCoughRifle02","Acts_InjuredLookingRifle01","Acts_InjuredLookingRifle02","Acts_InjuredLookingRifle03","Acts_InjuredLookingRifle04","Acts_InjuredLookingRifle05","Acts_InjuredLyingRifle01","Acts_InjuredLyingRifle02","Acts_InjuredLyingRifle02_180","Acts_InjuredSpeakingRifle01","Acts_SittingWounded_breath","Acts_SittingWounded_loop","Acts_ExecutionVictim_KillTerminal","Acts_Onchair_Dead","acts_millerDisarming_deskLoop","acts_millerDisarming_deskCrouch_loop"];

private _actSelected = _act select _condition;

if (_activated) then {
  {
    switch (_allowDamage) do {
      case 0: {[_x, false] remoteExec ["allowdamage", 0];};
      case 1: {[_x, false] remoteExec ["allowdamage", 1];};
    };

    [_x, _actSelected] remoteExec ["switchMove", 0, true];
    [_x, "ALL"] remoteExec ["disableAI", 0];
    [_x, "CARELESS"] remoteExec ["setBehaviour", 0];
  } forEach _vehicle;
};

