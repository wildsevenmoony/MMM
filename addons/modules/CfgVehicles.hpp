class CBA_Extended_EventHandlers_base;

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
			class Units; // Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
			class AnyAI;
			class AnyVehicle;
			class AnyStaticObject;
		};
	};

	class MMM_MODULES_Module_Base_Medic_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Base Medic";
		function = "MMM_MODULES_fnc_baseMedicInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Adds an ACE healing action to every synchronised object.";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any object to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyStaticObject", "AnyVehicle"};
			};
		};
	};

	class MMM_MODULES_Module_SpawnWreck_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Spawen Vehicle as Wreck";
		function = "MMM_MODULES_fnc_spawnWreck";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class MMM_MODULES_Module_SpawnWreck_ACE_Cooking_Off: Combo
  			{
				property = "MMM_MODULES_Module_SpawnWreck_ACE_Cooking_Off_Combo";
				displayName = "ACE Cook off";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class MMM_MODULES_Module_SpawnWreck_Destroy_Effect: Combo
  			{
				property = "MMM_MODULES_Module_SpawnWreck_Destroy_Effect_Combo";
				displayName = "Trigger explosion";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Vehicle to this module to spawn it as a wreck!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Vehicle to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyVehicle"};
			};
		};
	};

	class MMM_MODULES_Module_AmbientAnimationMP_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Ambient Animation MP";
		function = "MMM_MODULES_fnc_ambientAnimationMP";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class MMM_MODULES_Module_AmbientAnimationMP: Combo
  			{
				property = "MMM_MODULES_Module_AmbientAnimationMP_Combo";
				displayName = "Choose an Ambient Animation";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class Stand1	{name = "STAND1";	value = 0;};
					class Stand2	{name = "STAND2";	value = 1;};
					class Stand_U1	{name = "STAND_U1";	value = 2;};
					class Stand_U2	{name = "STAND_U2";	value = 3;};
					class Stand_U3	{name = "STAND_U3";	value = 4;};
					class WATCH	{name = "WATCH";	value = 5;};
					class WATCH2	{name = "WATCH2";	value = 6;};
					class GUARD	{name = "GUARD";	value = 7;};
					class LISTEN_BRIEFING	{name = "LISTEN_BRIEFING";	value = 8;};
					class LEAN_ON_TABLE	{name = "LEAN_ON_TABLE";	value = 9;};
					class LEAN	{name = "LEAN";	value = 10;};
					class SIT_AT_TABLE	{name = "SIT_AT_TABLE";	value = 11;};
					class SIT1	{name = "SIT1";	value = 12;};
					class SIT	{name = "SIT";	value = 13;};
					class SIT3	{name = "SIT3";	value = 14;};
					class SIT_U1	{name = "SIT_U1";	value = 15;};
					class SIT_U2	{name = "SIT_U2";	value = 16;};
					class SIT_U3	{name = "SIT_U3";	value = 17;};
					class SIT_HIGH1	{name = "SIT_HIGH1";	value = 18;};
					class SIT_HIGH	{name = "SIT_HIGH";	value = 19;};
					class SIT_LOW	{name = "SIT_LOW";	value = 20;};
					class SIT_LOW_U	{name = "SIT_LOW_U";	value = 21;};
					class SIT_SAD1	{name = "SIT_SAD1";	value = 22;};
					class SIT_SAD2	{name = "SIT_SAD2";	value = 23;};
					class KNEEL	{name = "KNEEL";	value = 24;};
					class REPAIR_VEH_PRONE	{name = "REPAIR_VEH_PRONE";	value = 25;};
					class REPAIR_VEH_KNEEL	{name = "REPAIR_VEH_KNEEL";	value = 26;};
					class REPAIR_VEH_STAND	{name = "REPAIR_VEH_STAND";	value = 27;};
					class PRONE_INJURED_U1	{name = "PRONE_INJURED_U1";	value = 28;};
					class PRONE_INJURED_U2	{name = "PRONE_INJURED_U2";	value = 29;};
					class PRONE_INJURED	{name = "PRONE_INJURED";	value = 30;};
					class KNEEL_TREAT	{name = "KNEEL_TREAT";	value = 31;};
					class KNEEL_TREAT2	{name = "KNEEL_TREAT2";	value = 32;};
					class BRIEFING	{name = "BRIEFING";	value = 33;};
					class BRIEFING_POINT_LEFT	{name = "BRIEFING_POINT_LEFT";	value = 34;};
					class BRIEFING_POINT_RIGHT	{name = "BRIEFING_POINT_RIGHT";	value = 35;};
					class BRIEFING_POINT_TABLE	{name = "BRIEFING_POINT_TABLE";	value = 36;};
				};
			};

			class MMM_MODULES_Module_AmbientAnimationMP_Snap_Object: Edit
  			{
				property = "MMM_MODULES_Module_AmbientAnimationMP_Snap_Object_Edit";
				displayName = "Assign an Object to snap to!";
				tooltip = "Leave empty if you don't want to snap to an object";
			};
			
			class MMM_MODULES_Module_AmbientAnimationMP_Damage: Combo
  			{
				property = "MMM_MODULES_Module_AmbientAnimationMP_Damage_Combo";
				displayName = "Allow Damage";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync an AI Unit to this module to make it play the selected Ambient Animation";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any AI to this module"};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyAI"};
			};
		};
	};

	class MMM_MODULES_Module_Animation_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "SwitchMove Animation";
		function = "MMM_MODULES_fnc_animation";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class MMM_MODULES_Module_Animation_Animations: Combo
  			{
					property = "MMM_MODULES_Module_Animation_Animations_Combo";
					displayName = "Choose an Animation";
					typeName = "NUMBER";
					defaultValue = "0";
					class Values
					{
						class Idle_Standing_1 {name = "Idle Standing 01"; value = 0;};
						class Idle_Standing_2 {name = "Idle Standing 02"; value = 1;};
						class Idle_Standing_3 {name = "Idle Standing 03"; value = 2;};
						class Idle_Standing_4 {name = "Idle Standing 04"; value = 3;};
						class Idle_Crossed_Arms_5 {name = "Idle Crossed Arms"; value = 4;};
						class Idle_Standing_Weapon_1 {name = "Idle Standing 01 (Weapon)"; value = 5;};
						class Idle_Standing_Weapon_2 {name = "Idle Standing 02 (Weapon)"; value = 6;};
						class Idle_Standing_Weapon_3 {name = "Idle Standing 03 (Weapon)"; value = 7;};
						class Talking_1 {name = "Talking 01"; value = 8;};
						class Talking_2 {name = "Talking 02"; value = 9;};
						class Talking_Radio {name = "Talking on Radio"; value = 10;};
						class Listen_Radio {name = "Listen on Radio"; value = 11;};
						class Speech {name = "Speech"; value = 12;};
						class Hostage_Sitting_1 {name = "Hostage Sitting 01"; value = 13;};
						class Hostage_Sitting_2 {name = "Hostage Sitting 02"; value = 14;};
						class Hostage_Sitting_3 {name = "Hostage Sitting 03"; value = 15;};
						class Hostage_Sitting_4 {name = "Hostage Sitting 04"; value = 16;};
						class Hostage_Sitting_5 {name = "Hostage Sitting 05"; value = 17;};
						class Hostage_Kneeling {name = "Hostage Kneeling"; value = 18;};
						class Sit_Shocked_1 {name = "Sit Shocked 01"; value = 19;};
						class Sit_Shocked_2 {name = "Sit Shocked 02"; value = 20;};
						class Kneel_Afraid_1 {name = "Kneel Afraid 01"; value = 21;};
						class Kneel_Afraid_2 {name = "Kneel Afraid 02"; value = 22;};
						class Injured_Bed_1 {name = "Injured Bed 01"; value = 23;};
						class Injured_Bed_2 {name = "Injured Bed 02"; value = 24;};
						class Injured_Bed_3 {name = "Injured Bed 03"; value = 25;};
						class Injured_lying_5 {name = "Lying Insured"; value = 26;};
						class Injured_lyingarm_1 {name = "Lying Insured Arm"; value = 27;};
						class Injured_lyingchest_2 {name = "Lying Insured Chest"; value = 28;};
						class Injured_lyinghead_3 {name = "Lying Insured Head"; value = 29;};
						class Injured_lyingleg_4 {name = "Lying Insured Leg"; value = 30;};
						class Injured_Weapon_Arm {name = "Lying Insured Arm (Weapon)"; value = 31;};
						class Injured_Weapon_Chest {name = "Lying Insured Chest (Weapon)"; value = 32;};
						class Injured_Weapon_Head {name = "Lying Insured Head (Weapon)"; value = 33;};
						class Injured_Weapon_Leg {name = "Lying Insured Leg (Weapon)"; value = 34;};
						class Injured_Weapon_Angry {name = "Lying Insured Angry"; value = 35;};
						class Injured_Weapon_Coughing {name = "Lying Insured Coughing (Weapon)"; value = 36;};
						class Injured_Weapon_1 {name = "Injured_Weapon_1"; value = 37;};
						class Injured_Weapon_2 {name = "Injured_Weapon_2"; value = 38;};
						class Injured_Weapon_3 {name = "Injured_Weapon_3"; value = 39;};
						class Injured_Weapon_4 {name = "Injured_Weapon_4"; value = 40;};
						class Injured_Weapon_5 {name = "Injured_Weapon_5"; value = 41;};
						class Injured_Weapon_6 {name = "Injured_Weapon_6"; value = 42;};
						class Injured_Weapon_7 {name = "Injured_Weapon_7"; value = 43;};
						class Injured_Weapon_7_180 {name = "Injured_Weapon_7_180"; value = 44;};
						class Injured_Weapon_8 {name = "Injured_Weapon_8"; value = 45;};
						class Injured_Pistol_1 {name = "Injured_Pistol_1"; value = 46;};
						class Injured_Pistol_2 {name = "Injured_Pistol_2"; value = 47;};
						class Dead_Captured {name = "Dead Captured"; value = 48;};
						class Dead_Chair {name = "Dead in Chair"; value = 49;};
						class Typing_Combat_Bowed {name = "Typing Bowed"; value = 50;};
						class Typing_Combat_Kneeling {name = "Typing Kneeling"; value = 51;};
					};
			};
			
			class MMM_MODULES_Module_Animation_Damage: Combo
  			{
				property = "MMM_MODULES_Module_Animation_Damage_Combo";
				displayName = "Allow Damage";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync an AI Unit to this module to make it play the selected Animation";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any AI to this module"};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyAI"};
			};
		};
	};

	class MMM_MODULES_Module_AI_Stationary_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Turn AI Stationary";
		function = "MMM_MODULES_fnc_stationaryAIInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class MMM_MODULES_Module_AI_Stationary: Combo
  			{
					property = "MMM_MODULES_Module_AI_Stationary_Combo";
					displayName = "Single AI or Group?";
					typeName = "NUMBER";
					defaultValue = "0";
					class Values
					{
						class group {name = "Group"; value = 0;};
						class single {name = "Single AI"; value = 1;};
					};
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Turns AI Stationary";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any object to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyStaticObject", "AnyVehicle", "AnyAI"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Backpacks_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Backpacks";
		function = "MMM_MODULES_fnc_randomizeGearBackpacksInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
				class MMM_BackpacksCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Backpacks Attributes";
					description = "";
				};

				class MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the backpacks randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Backpacks_Force: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Backpacks_Force_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds backpacks even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Chance_Edit";
					displayName = "Empty Chance";
					tooltip = "Enter the chance for the backpacks being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no backpacks being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Backpacks_Randomize_Content_Edit";
					tooltip = "Enter classnames of Backpacks. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its backpacks!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Goggles_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Goggles";
		function = "MMM_MODULES_fnc_randomizeGearGogglesInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
				class MMM_GogglesCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Goggles Attributes";
					description = "";
				};

				class MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the vests randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Goggles_Force: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Goggles_Force_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds vests even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Chance_Edit";
					displayName = "Empty Chance";
					tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Goggles_Randomize_Content_Edit";
					tooltip = "Enter classnames of Goggles. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its vests!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Headgear_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Headgear";
		function = "MMM_MODULES_fnc_randomizeGearHeadgearInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
				class MMM_HeadgearCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Headgear Attributes";
					description = "";
				};

				class MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the headgear randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Headgear_Force: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Headgear_Force_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds headgear even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Chance_Edit";
					displayName = "Empty Chance";
					tooltip = "Enter the chance for the headgear being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no headgear being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Headgear_Randomize_Content_Edit";
					tooltip = "Enter classnames of Headgear. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its headgear!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Uniforms_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Uniforms";
		function = "MMM_MODULES_fnc_randomizeGearUniformsInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
				class MMM_UniformsCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Uniforms Attributes";
					description = "";
				};

				class MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the uniforms randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Uniforms_Force: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Uniforms_Force_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds uniforms even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Chance_Edit";
					displayName = "Empty Chance";
					tooltip = "Enter the chance for the uniforms being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no uniforms being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Uniforms_Randomize_Content_Edit";
					tooltip = "Enter classnames of Uniforms. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its uniforms!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Vests_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Vests";
		function = "MMM_MODULES_fnc_randomizeGearVestsInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
				class MMM_VestsCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Vests Attributes";
					description = "";
				};

				class MMM_MODULES_Module_Randomize_Gear_Vests_Randomize: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the vests randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Vests_Force: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Vests_Force_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds vests even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Chance_Edit";
					displayName = "Empty Chance";
					tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Vests_Randomize_Content_Edit";
					tooltip = "Enter classnames of Vests. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its vests!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class MMM_MODULES_Module_Randomize_Gear_Weapons_F: Module_F
	{
		category = "MMM_MODULES_ModuleClass";
		displayName = "Gear Randomizer: Weapons";
		function = "MMM_MODULES_fnc_randomizeGearWeaponsInit";
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			// Primary Weapon
				class MMM_PrimaryCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Primary Weapons Attributes";
					description = "";
				};
				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the primary weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Primary: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Primary_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds a primary weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Content_Edit";
					tooltip = "Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Checkbox ";
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Chance_Edit";
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Scope_Content_Edit";
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Checkbox ";
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Chance_Edit";
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Rail_Content_Edit";
					tooltip = "Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Checkbox ";
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Chance_Edit";
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Muzzle_Content_Edit";
					tooltip = "Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Checkbox ";
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Chance_Edit";
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Primary_Attachment_Bipod_Content_Edit";
					tooltip = "Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
					displayName = "[Bipod] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			// Sidearm Weapon
				class MMM_SidearmCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Sidearm Weapons Attributes";
					description = "";
				};
				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the sidearm weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Sidearm: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Sidearm_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds a sidearm weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Content_Edit";
					tooltip = "Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Checkbox ";
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Chance_Edit";
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Scope_Content_Edit";
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Checkbox ";
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Chance_Edit";
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Rail_Content_Edit";
					tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Checkbox ";
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Chance_Edit";
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Muzzle_Content_Edit";
					tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Checkbox ";
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Chance_Edit";
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Sidearm_Attachment_Bipod_Content_Edit";
					tooltip = "Enter classnames of bipods. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
					displayName = "[Bipod] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			// Secondary Weapon
				class MMM_SecondaryCategory {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Secondary Weapons Attributes";
					description = "";
				};
				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Checkbox ";
					displayName = "Randomize";
					tooltip = "Activate the secondary weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Secondary: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Force_Secondary_Checkbox ";
					displayName = "Force adding";
					tooltip = "Adds a secondary weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Content_Edit";
					tooltip = "Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Checkbox ";
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Chance_Edit";
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Scope_Content_Edit";
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Checkbox ";
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Chance_Edit";
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Rail_Content_Edit";
					tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Checkbox ";
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Chance_Edit";
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Muzzle_Content_Edit";
					tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod: Checkbox 
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Checkbox ";
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Chance: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Chance_Edit";
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Content: Edit
				{
					property = "MMM_MODULES_Module_Randomize_Gear_Weapons_Randomize_Secondary_Attachment_Bipod_Content_Edit";
					tooltip = "Enter classnames of bipods. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
					displayName = "[Bipod] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its weapons!";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any Unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyBrain"};
			};
		};
	};
};
