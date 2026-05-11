/*
 * Author: Moony
 * Randomizes the goggle of the unit 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Enable Randomization <BOOL>
 * 2: Force adding Goggle <BOOL>
 * 3: Classnames for randomization <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true, "G_Balaclava_blk,G_Bandanna_blk,G_Shades_Black"] call mmm_modules_fnc_randomizeGearGoggles.sqf
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
	"_randomizeGoggles",
	"_forceGoggles",
	"_chanceGoggles",
	"_contentGoggles"
];

_unit setVariable [QGVAR(randomizationGogglesDone), false];

// Randomizes Goggles if enabled
if (_randomizeGoggles && ((_forceGoggles) || (!_forceGoggles && (goggles _unit) != ""))) then {
	private _gogglesArray = [""];

	if (_contentGoggles isNotEqualTo "" && {_contentGoggles isNotEqualTo "[]"}) then {
		_gogglesArray = ([_contentGoggles] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedGoggles = selectRandom _gogglesArray;

	// Remove Goggles
	removeGoggles _unit;

	// Add new Goggles
	if ((random 1 > _chanceGoggles) && {_selectedGoggles != ""}) then {
		_unit addGoggles _selectedGoggles;
	};

	_unit setVariable [QGVAR(randomizationGogglesSelected), _selectedGoggles, true];
};

_unit setVariable [QGVAR(randomizationGogglesDone), true, true];
