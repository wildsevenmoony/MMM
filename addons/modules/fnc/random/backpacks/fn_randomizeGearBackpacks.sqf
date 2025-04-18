params [
	"_unit",
	"_randomizeBackpacks",
	"_forceBackpacks",
	"_contentBackpacks",
	"_chanceBackpacks"
];

// Randomizes Backpacks if enabled
if (_randomizeBackpacks && ((_forceBackpacks) || (!_forceBackpacks && (backpack _unit) != ""))) then {
	#include "fn_defaultBackpacks.hpp"

	if (_contentBackpacks isNotEqualTo "" || _contentBackpacks isNotEqualTo "[]") then {
		_backpacksArray = ([_contentBackpacks] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedBackpacks = selectRandom _backpacksArray;

	// Save Content of Backpack
	private _currentContent = backpackItems _unit;

	// Remove Backpacks
	removeBackpack _unit;

	// Add new Backpacks
	if (random 1 <= _chanceBackpacks) then {
	} else {
		_unit addBackpack _selectedBackpacks;
	};

	//Add content back
	{
		_unit addItemToBackpack _x;
	} forEach _currentContent;

	_unit setVariable ["MMM_var_randomizationBackpacksSelected", _selectedBackpacks, true];
};

_unit setVariable ["MMM_var_randomizationBackpacksDone", true, true];
