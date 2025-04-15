params [
	"_unit",
	"_randomizeUniforms",
	"_forceUniforms",
	"_contentUniforms",
	"_chanceUniforms"
];

_unit setVariable ["MMM_var_randomizationUniformsDone", false];

// Randomizes Uniforms if enabled
if (_randomizeUniforms && ((_forceUniforms) || (!_forceUniforms && (uniform _unit) != ""))) then {
	#include "fn_defaultUniforms.hpp"

	if (_contentUniforms isNotEqualTo "" || _contentUniforms isNotEqualTo "[]") then {
		private _uniformsArray = ([_contentUniforms] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedUniforms = selectRandom _uniformsArray;

	// Save Content of Uniform
	private _currentContent = uniformItems _unit;

	// Remove Uniforms
	removeUniform _unit;

	// Add new Uniforms
	if (random 1 < _chanceUniforms) then {
	} else {
		_unit forceAddUniform _selectedUniforms;
	};

	//Add content back
	{
		_unit addItemToUniform _x;
	} forEach _currentContent;
};

_unit setVariable ["MMM_var_randomizationUniformsDone", true, true];