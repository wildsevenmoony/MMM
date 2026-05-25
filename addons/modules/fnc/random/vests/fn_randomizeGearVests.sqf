/*
 * Author: Moony
 * Randomizes the vests of the unit 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Enable Randomization <BOOL>
 * 2: Force adding Vests <BOOL>
 * 3: Classnames for randomization <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true, "V_BandollierB_blk,V_Chestrig_blk,V_PlateCarrier1_blk"] call mmm_modules_fnc_randomizeGearVests
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
	"_randomizeVests",
	"_forceVests",
	"_chanceVests",
	"_contentVests"
];

_unit setVariable [QGVAR(randomizationVestsDone), false];

// Randomizes Vests if enabled
if (_randomizeVests && ((_forceVests) || (!_forceVests && (vest _unit) != ""))) then {
	private _vestsArray = [_contentVests] call EFUNC(modules,parseClassnameList);
	private _selectedVests = selectRandom _vestsArray;

	// Save Content of Vest
	private _currentContent = vestItems _unit;

	// Remove Vests
	removeVest _unit;

	// Add new Vests
	if ((random 1 > _chanceVests) && {_selectedVests != ""}) then {
		_unit addVest _selectedVests;
	};

	//Add content back
	if (vest _unit != "") then {
		{
			_unit addItemToVest _x;
		} forEach _currentContent;
	};

	_unit setVariable [QGVAR(randomizationVestsSelected), _selectedVests, true];
};

_unit setVariable [QGVAR(randomizationVestsDone), true, true];
