params [
  ["_logic", objNull,[objNull]],
	["_vehicle", [], [[]]],
  ["_activated",true ,[true]]
];

private _condition = _logic getVariable ["MMM_MODULES_Module_Animation_Animations", 0];
private _allowDamage = _logic getVariable ["MMM_MODULES_Module_Animation_Damage", 0];
private _noweapon = [13,14,15,16,17,18,0,1,2,3,4,8,9,10,11,12,19,20,21,22,23,24,25,48];
private _weaponornot = [27,28,29,30,26,49];
private _weapon = [5,6,7,50,51,35,36,37,38,39,40,41,42,43,44,45,46,47];

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

