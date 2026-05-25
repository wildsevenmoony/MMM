/*
 * Author: Moony
 * Opens a ZEN dialog to randomize weapons and attachments for one unit or its group.
 *
 * Arguments:
 * 0: Module position <ARRAY>
 * 1: Object under cursor <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [position player, cursorObject] call mmm_modules_fnc_randomizeGearWeaponsGroupZeus
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
	"WEAPONS RANDOMIZATION",
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
		// Weapons
			// Primary Weapons
				[
					"CHECKBOX", // Type
					[
						"Randomization", // Title
						"Activate the primary weapon randomization" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"CHECKBOX", // Type
					[
						"Force adding", // Title
						"Adds a primary weapon even if the unit did not have one before" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"EDIT", // Type
					[
						"Classnames", // Title
						"Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F..." // Tooltip
					],
					[
						"" // Default text
					], // Control Specific Argument(s)
					false // Force Default
				],
				// Scopes
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the scope randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added" // Tooltip
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
							"Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Rail
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the rail attachment randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added" // Tooltip
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
							"Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Muzzle
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the muzzle randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added" // Tooltip
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
							"Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Bipod
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the bipod randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added" // Tooltip
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
							"Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
			// Sidearm Weapons
				[
					"CHECKBOX", // Type
					[
						"Randomization", // Title
						"Activate the sidearm weapon randomization" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"CHECKBOX", // Type
					[
						"Force adding", // Title
						"Adds a sidearm weapon even if the unit did not have one before" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"EDIT", // Type
					[
						"Classnames", // Title
						"Enter classnames of Weapons. \n\nE.g. hgun_P07_blk_F,hgun_Rook40_F,hgun_P07_F..." // Tooltip
					],
					[
						"" // Default text
					], // Control Specific Argument(s)
					false // Force Default
				],
				// Scopes
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the scope randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added" // Tooltip
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
							"Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Rail
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the rail attachment randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added" // Tooltip
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
							"Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Muzzle
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the muzzle randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added" // Tooltip
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
							"Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Bipod
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the bipod randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added" // Tooltip
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
							"Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
			// Secondary Weapons
				[
					"CHECKBOX", // Type
					[
						"Randomization", // Title
						"Activate the secondary weapon randomization" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"CHECKBOX", // Type
					[
						"Force adding", // Title
						"Adds a secondary weapon even if the unit did not have one before" // Tooltip
					],
					false, // Default State
					false // Force Default
				],
				[
					"EDIT", // Type
					[
						"Classnames", // Title
						"Enter classnames of Weapons. \n\nE.g. launch_NLAW_F,launch_RPG32_F,launch_MRAWS_green_F..." // Tooltip
					],
					[
						"" // Default text
					], // Control Specific Argument(s)
					false // Force Default
				],
				// Scopes
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the scope randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added" // Tooltip
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
							"Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Rail
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the rail attachment randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added" // Tooltip
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
							"Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Muzzle
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the muzzle randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added" // Tooltip
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
							"Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty" // Tooltip
						],
						[
							"" // Default text
						], // Control Specific Argument(s)
						false // Force Default
					],
				// Bipod
					[
						"CHECKBOX", // Type
						[
							"Randomization", // Title
							"Activates the bipod randomization" // Tooltip
						],
						false, // Default State
						false // Force Default
					],
					[
						"SLIDER", // Type
						[
							"Empty Chance", // Title
							"Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added" // Tooltip
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
							"Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty" // Tooltip
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
			"_randomizePrimary",
			"_forcePrimary",
			"_contentPrimary",
			"_randomizePrimaryScope",
			"_chancePrimaryScope",
			"_contentPrimaryScope",
			"_randomizePrimaryRail",
			"_chancePrimaryRail",
			"_contentPrimaryRail",
			"_randomizePrimaryMuzzle",
			"_chancePrimaryMuzzle",
			"_contentPrimaryMuzzle",
			"_randomizePrimaryBipod",
			"_chancePrimaryBipod",
			"_contentPrimaryBipod",
			"_randomizeSidearm",
			"_forceSidearm",
			"_contentSidearm",
			"_randomizeSidearmScope",
			"_chanceSidearmScope",
			"_contentSidearmScope",
			"_randomizeSidearmRail",
			"_chanceSidearmRail",
			"_contentSidearmRail",
			"_randomizeSidearmMuzzle",
			"_chanceSidearmMuzzle",
			"_contentSidearmMuzzle",
			"_randomizeSidearmBipod",
			"_chanceSidearmBipod",
			"_contentSidearmBipod",
			"_randomizeSecondary",
			"_forceSecondary",
			"_contentSecondary",
			"_randomizeSecondaryScope",
			"_chanceSecondaryScope",
			"_contentSecondaryScope",
			"_randomizeSecondaryRail",
			"_chanceSecondaryRail",
			"_contentSecondaryRail",
			"_randomizeSecondaryMuzzle",
			"_chanceSecondaryMuzzle",
			"_contentSecondaryMuzzle",
			"_randomizeSecondaryBipod",
			"_chanceSecondaryBipod",
			"_contentSecondaryBipod"];

		switch (_randomizeGroup) do {
			case true: {
				{
					if (_randomizePrimary || _randomizeSidearm || _randomizeSecondary) then {
						[_x,_randomizePrimary,_forcePrimary,_contentPrimary,_randomizePrimaryScope,_chancePrimaryScope,_contentPrimaryScope,_randomizePrimaryRail,_chancePrimaryRail,_contentPrimaryRail,_randomizePrimaryMuzzle,_chancePrimaryMuzzle,_contentPrimaryMuzzle,_randomizePrimaryBipod,_chancePrimaryBipod,_contentPrimaryBipod,_randomizeSidearm,_forceSidearm,_contentSidearm,_randomizeSidearmScope,_chanceSidearmScope,_contentSidearmScope,_randomizeSidearmRail,_chanceSidearmRail,_contentSidearmRail,_randomizeSidearmMuzzle,_chanceSidearmMuzzle,_contentSidearmMuzzle,_randomizeSidearmBipod,_chanceSidearmBipod,_contentSidearmBipod,_randomizeSecondary,_forceSecondary,_contentSecondary,_randomizeSecondaryScope,_chanceSecondaryScope,_contentSecondaryScope,_randomizeSecondaryRail,_chanceSecondaryRail,_contentSecondaryRail,_randomizeSecondaryMuzzle,_chanceSecondaryMuzzle,_contentSecondaryMuzzle,_randomizeSecondaryBipod,_chanceSecondaryBipod,_contentSecondaryBipod] call EFUNC(modules,randomizeGearWeapons);
					};
				} forEach units group _objectUnderCursor;

				[objNull, "GROUPS GEAR RANDOMIZED"] call BIS_fnc_showCuratorFeedbackMessage;
			};
			case false: {
				if (_randomizePrimary || _randomizeSidearm || _randomizeSecondary) then {
					[_objectUnderCursor,_randomizePrimary,_forcePrimary,_contentPrimary,_randomizePrimaryScope,_chancePrimaryScope,_contentPrimaryScope,_randomizePrimaryRail,_chancePrimaryRail,_contentPrimaryRail,_randomizePrimaryMuzzle,_chancePrimaryMuzzle,_contentPrimaryMuzzle,_randomizePrimaryBipod,_chancePrimaryBipod,_contentPrimaryBipod,_randomizeSidearm,_forceSidearm,_contentSidearm,_randomizeSidearmScope,_chanceSidearmScope,_contentSidearmScope,_randomizeSidearmRail,_chanceSidearmRail,_contentSidearmRail,_randomizeSidearmMuzzle,_chanceSidearmMuzzle,_contentSidearmMuzzle,_randomizeSidearmBipod,_chanceSidearmBipod,_contentSidearmBipod,_randomizeSecondary,_forceSecondary,_contentSecondary,_randomizeSecondaryScope,_chanceSecondaryScope,_contentSecondaryScope,_randomizeSecondaryRail,_chanceSecondaryRail,_contentSecondaryRail,_randomizeSecondaryMuzzle,_chanceSecondaryMuzzle,_contentSecondaryMuzzle,_randomizeSecondaryBipod,_chanceSecondaryBipod,_contentSecondaryBipod] call EFUNC(modules,randomizeGearWeapons);
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
