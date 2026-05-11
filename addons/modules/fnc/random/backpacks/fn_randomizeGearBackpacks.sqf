/*
 * Author: Moony
 * Randomizes the backpack of the unit 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Enable Randomization <BOOL>
 * 2: Force adding Backpack <BOOL>
 * 3: Classnames for randomization <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true, "B_AssaultPack_blk,B_Bergen_blk,B_Carryall_blk"] call mmm_modules_fnc_randomizeGearBackpacks.sqf
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
	"_randomizeBackpacks",
	"_forceBackpacks",
	"_chanceBackpacks",
	"_contentBackpacks"
];

// Randomizes Backpacks if enabled
if (_randomizeBackpacks && ((_forceBackpacks) || (!_forceBackpacks && (backpack _unit) != ""))) then {
	private _backpacksArray = [""];

	if (_contentBackpacks isNotEqualTo "" && {_contentBackpacks isNotEqualTo "[]"}) then {
		_backpacksArray = ([_contentBackpacks] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedBackpacks = selectRandom _backpacksArray;

	// Save Content of Backpack
	private _currentContent = backpackItems _unit;

	// Remove Backpacks
	removeBackpack _unit;

	// Add new Backpacks
	if ((random 1 > _chanceBackpacks) && {_selectedBackpacks != ""}) then {
		_unit addBackpack _selectedBackpacks;
	};

	//Add content back
	if (backpack _unit != "") then {
		{
			_unit addItemToBackpack _x;
		} forEach _currentContent;
	};

	_unit setVariable [QGVAR(randomizationBackpacksSelected), _selectedBackpacks, true];
};

_unit setVariable [QGVAR(randomizationBackpacksDone), true, true];
