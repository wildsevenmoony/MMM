/*
 * Author: Moony
 * Opens a ZEN dialog to randomize headgear for one unit or its group.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_randomizeGearHeadgearGroupZeus
 *
 * Public: No
 */
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	["_position", [], [[]]],
	["_objectUnderCursor", objNull, [objNull]]
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

// Dialog
[
	"HEADGEAR RANDOMIZATION",
	[
		// Main
			[
				"CHECKBOX", // Type
				[
					"Group", // Title
					"Should every unit in the group be randomized?" // Tooltip
				],
				false, // Default State
				false // Force Default
			],
		// Headgear
			[
				"CHECKBOX", // Type
				[
					"Randomization", // Title
					"Activate Headgear Randomization" // Tooltip
				],
				false, // Default State
				false // Force Default
			],
			[
				"CHECKBOX", // Type
				[
					"Force adding", // Title
					"Adds headgear even if the unit did not have one before" // Tooltip
				],
				false, // Default State
				false // Force Default
			],
			[
				"SLIDER", // Type
				[
					"Empty Chance", // Title
					"Enter the chance for the backpacks being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no backpacks being added" // Tooltip
				],
				[
					0, // Min. Value
					1, // Max. Value
					0, // Default Value
					2 // Number of Decimals
				], // Control Specific Argument(s)
				false // Force Default
			],
			[
				"EDIT", // Type
				[
					"Classnames", // Title
					"Enter classnames of Backpacks. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo..." // Tooltip
				],
				[
					"" // Default text
				], // Control Specific Argument(s)
				false // Force Default
			]
	], // Content
	{
		params ["_dialogValues", "_objectUnderCursor"];
		_dialogValues params [
			"_randomizeGroup",
			"_randomizeHeadgear",
			"_forceHeadgear",
			"_chanceHeadgear",
			"_contentHeadgear"];

		private _targets = if (_randomizeGroup) then {units group _objectUnderCursor} else {[_objectUnderCursor]};

		if (_randomizeHeadgear) then {
			{
				[_x,_randomizeHeadgear,_forceHeadgear,_chanceHeadgear,_contentHeadgear] call EFUNC(modules,randomizeGearHeadgear);
			} forEach _targets;
		};

		private _message = ["UNITS GEAR RANDOMIZED", "GROUPS GEAR RANDOMIZED"] select _randomizeGroup;
		[objNull, _message] call BIS_fnc_showCuratorFeedbackMessage;
	}, // On Confirm
	{
		[objNull, " RANDOMIZATION ABORTED"] call BIS_fnc_showCuratorFeedbackMessage;
	}, // On Cancel
	_objectUnderCursor // Arguments
] call zen_dialog_fnc_create;
