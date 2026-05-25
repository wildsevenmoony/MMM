/*
 * Author: Moony
 * Randomizes the headgear of the unit 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Enable Randomization <BOOL>
 * 2: Force adding Headgear <BOOL>
 * 3: Classnames for randomization <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true, "H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo"] call mmm_modules_fnc_randomizeGearHeadgear
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
	"_randomizeHeadgear",
	"_forceHeadgear",
	"_chanceHeadgear",
	"_contentHeadgear"
];

_unit setVariable [QGVAR(randomizationHeadgearDone), false];

// Randomizes Headgear if enabled
if (_randomizeHeadgear && ((_forceHeadgear) || (!_forceHeadgear && (headgear _unit) != ""))) then {
	private _headgearArray = [_contentHeadgear] call EFUNC(modules,parseClassnameList);
	private _selectedHeadgear = selectRandom _headgearArray;

	// Remove Headgear
	removeHeadgear _unit;

	// Add new Headgear
	if ((random 1 > _chanceHeadgear) && {_selectedHeadgear != ""}) then {
		_unit addHeadgear _selectedHeadgear;
	};

	_unit setVariable [QGVAR(randomizationHeadgearSelected), _selectedHeadgear, true];
};

_unit setVariable [QGVAR(randomizationHeadgearDone), true, true];
