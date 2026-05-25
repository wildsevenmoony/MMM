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
  // Module combo values are 0 = No and 1 = Yes; the engine calls below need booleans.
  private _enableCookOff = _cookOff == 1;
  private _useExplosionEffect = _explosionEffect == 1;

  {
    _x setVariable ["ace_cookoff_enable", _enableCookOff, true];
    _x setVariable ["ace_cookoff_enableAmmoCookoff", _enableCookOff, true];
    _x setDamage [1, _useExplosionEffect];
  } forEach _vehicle;
};
