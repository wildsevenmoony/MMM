params [
  ["_logic", objNull,[objNull]],
	["_vehicle", [], [[]]],
  ["_activated",true ,[true]]
];

_cookOff = _logic getVariable ["MMM_MODULES_Module_SpawnWreck_ACE_Cooking_Off", 0];
_explosionEffect = _logic getVariable ["MMM_MODULES_Module_SpawnWreck_Destroy_Effect", 0];

if (_activated) then {
  {
    switch (_cookOff) do {
      case 0: {
        _x setVariable ["ace_cookoff_enable", false, true];
        _x setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
      };
      case 1: { 
        _x setVariable ["ace_cookoff_enable", true, true];
        _x setVariable ["ace_cookoff_enableAmmoCookoff", true, true];
      };
    };

    switch (_explosionEffect) do {
      case 0: {_x setDamage [1, false];};
      case 1: {_x setDamage [1, true];};
    };
  } forEach _vehicle;
};