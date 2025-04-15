params [
	"_unit",
	"_randomizeVests",
	"_forceVests",
	"_contentVests",
	"_chanceVests"
];

_unit setVariable ["MMM_var_randomizationVestsDone", false];

// Randomizes Vests if enabled
if (_randomizeVests && ((_forceVests) || (!_forceVests && (vest _unit) != ""))) then {
	#include "fn_defaultVests.hpp"

	if (_contentVests isNotEqualTo "" || _contentVests isNotEqualTo "[]") then {
		private _vestsArray = ([_contentVests] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedVests = selectRandom _vestsArray;

	// Save Content of Vest
	private _currentContent = vestItems _unit;

	// Remove Vests
	removeVest _unit;

	// Add new Vests
	if (random 1 < _chanceVests) then {
	} else {
		_unit addVest _selectedVests;
	};

	//Add content back
	{
		_unit addItemToVest _x;
	} forEach _currentContent;
};

_unit setVariable ["MMM_var_randomizationVestsDone", true, true];