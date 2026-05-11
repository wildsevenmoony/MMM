// Get all the passed parameters
#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_position",
	"_objectUnderCursor"
];

#include "..\checks\fn_notNullUnit.hpp"
#include "..\checks\fn_placeOnUnit.hpp"
#include "..\checks\fn_isAlive.hpp"

// Dialog
[
	"GOGGLE RANDOMIZATION",
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
		// Goggles
			[
				"CHECKBOX", // Type
				[
					"Randomization", // Title
					"Activate Goggle Randomization" // Tooltip
				],
				false, // Default State
				false // Force Default
			],
			[
				"CHECKBOX", // Type
				[
					"Force adding", // Title
					"Adds goggles even if the unit did not have one before" // Tooltip
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
			"_randomizeGoggles",
			"_forceGoggles",
			"_chanceGoggles",
			"_contentGoggles"];

		switch (_randomizeGroup) do {
			case true: {
				{
					if (_randomizeGoggles) then {
						[_x,_randomizeGoggles,_forceGoggles,_chanceGoggles,_contentGoggles] call EFUNC(modules,randomizeGearGoggles);
					};
				} forEach units group _objectUnderCursor;

				[objNull, "GROUPS GEAR RANDOMIZED"] call BIS_fnc_showCuratorFeedbackMessage;
			};
			case false: {
				if (_randomizeGoggles) then {
					[_objectUnderCursor,_randomizeGoggles,_forceGoggles,_chanceGoggles,_contentGoggles] call EFUNC(modules,randomizeGearGoggles);
				};

				[objNull, "UNITS GEAR RANDOMIZED"] call BIS_fnc_showCuratorFeedbackMessage;
			};
		};
	}, // On Confirm
	{
		[objNull, " RANDOMIZATION ABORTED"] call BIS_fnc_showCuratorFeedbackMessage;
	}, // On Cancel
	_objectUnderCursor // Arguments
] call zen_dialog_fnc_create;
