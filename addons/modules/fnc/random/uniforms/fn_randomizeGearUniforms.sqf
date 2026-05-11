/*
 * Author: Moony
 * Randomizes the uniform of the unit 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Enable Randomization <BOOL>
 * 2: Force adding Uniform <BOOL>
 * 3: Classnames for randomization <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true, "U_BG_Guerilla1_1,U_B_CombatUniform_mcam_tshirt,U_B_GEN_Commander_F"] call mmm_modules_fnc_randomizeGearUniform.sqf
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
	"_randomizeUniforms",
	"_forceUniforms",
	"_chanceUniforms",
	"_contentUniforms"
];

_unit setVariable [QGVAR(randomizationUniformsDone), false];

// Randomizes Uniforms if enabled
if (_randomizeUniforms && ((_forceUniforms) || (!_forceUniforms && (uniform _unit) != ""))) then {
	private _uniformsArray = [""];

	if (_contentUniforms isNotEqualTo "" && {_contentUniforms isNotEqualTo "[]"}) then {
		_uniformsArray = ([_contentUniforms] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _selectedUniforms = selectRandom _uniformsArray;

	// Save Content of Uniform
	private _currentContent = uniformItems _unit;

	// Remove Uniforms
	removeUniform _unit;

	// Add new Uniforms
	if ((random 1 > _chanceUniforms) && {_selectedUniforms != ""}) then {
		_unit forceAddUniform _selectedUniforms;
	};

	//Add content back
	if (uniform _unit != "") then {
		{
			_unit addItemToUniform _x;
		} forEach _currentContent;
	};

	_unit setVariable [QGVAR(randomizationUniformsSelected), _selectedUniforms, true];
};

_unit setVariable [QGVAR(randomizationUniformsDone), true, true];
