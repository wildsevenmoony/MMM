/*
 * Author: Moony
 * Module: Destroys the Vehicle when activated. Predefined Parameters need to be selected in the corresponding module 
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

private _cookOff = _logic getVariable [QGVAR(spawnWreckACECookingOff), _logic getVariable ["MMM_MODULES_Module_SpawnWreck_ACE_Cooking_Off", 0]];
private _explosionEffect = _logic getVariable [QGVAR(spawnWreckDestroyEffect), _logic getVariable ["MMM_MODULES_Module_SpawnWreck_Destroy_Effect", 0]];

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
