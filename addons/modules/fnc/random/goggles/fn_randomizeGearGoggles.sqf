params [
	"_unit",
	"_randomizeGoggles",
	"_forceGoggles",
	"_contentGoggles",
	"_chanceGoggles"
];

_unit setVariable ["MMM_var_randomizationGogglesDone", false];

// Randomizes Goggles if enabled
if (_randomizeGoggles && ((_forceGoggles) || (!_forceGoggles && (vest _unit) != ""))) then {
	#include "fn_defaultGoggles.hpp"

	if (_contentGoggles isNotEqualTo "" || _contentGoggles isNotEqualTo "[]") then {
		_gogglesArray = ([_contentGoggles] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedGoggles = selectRandom _gogglesArray;

	// Save Content of Goggles
	private _currentContent = vestItems _unit;

	// Remove Goggles
	removeGoggles _unit;

	// Add new Goggles
	if (random 1 <= _chanceGoggles) then {
	} else {
		_unit addGoggles _selectedGoggles;
	};

	_unit setVariable ["MMM_var_randomizationGogglesSelected", _selectedGoggles, true];
};

_unit setVariable ["MMM_var_randomizationGogglesDone", true, true];