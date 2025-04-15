params [
	"_unit",
	"_randomizeHeadgear",
	"_forceHeadgear",
	"_contentHeadgear",
	"_chanceHeadgear"
];

_unit setVariable ["MMM_var_randomizationHeadgearDone", false];

// Randomizes Headgear if enabled
if (_randomizeHeadgear && ((_forceHeadgear) || (!_forceHeadgear && (headgear _unit) != ""))) then {
	#include "fn_defaultHeadgear.hpp"

	if (_contentHeadgear isNotEqualTo "" || _contentHeadgear isNotEqualTo "[]") then {
		private _headgearArray = ([_contentHeadgear] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedHeadgear = selectRandom _headgearArray;

	// Remove Headgear
	removeHeadgear _unit;

	// Add new Headgear
	if (random 1 < _chanceHeadgear) then {
	} else {
		_unit addHeadgear _selectedHeadgear;
	};
};

_unit setVariable ["MMM_var_randomizationHeadgearDone", true, true];