/*
 * Author: Moony
 * Module: Initializes the Base Medic script for each synced unit
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
    ["_logic", objNull, [objNull]],
	["_objs", [], [[]]]
];

{
	[_x] call EFUNC(modules,baseMedic);
} forEach _objs;
