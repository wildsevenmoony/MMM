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
		function = "MMM_MODULES_fnc_spawnwreck";
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
		function = "MMM_MODULES_fnc_ambientanimationmp";
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
		function = "MMM_MODULES_fnc_stationary_ai_init";
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
};
