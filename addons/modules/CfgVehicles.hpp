class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class ModuleDescription; // Module description
		};
		// Description base classes, for more information see below
		class ModuleDescription;
	};

	class GVAR(aceDamage): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Apply ACE Damage";
		function = QEFUNC(modules,aceDamageInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(aceDamageGeneralCategory)
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "General";
				description = "";
			};

			class GVAR(aceDamageMode): Combo
			{
				property = QGVAR(aceDamageMode);
				displayName = "Damage Mode";
				tooltip = "Specific applies configured damage to every enabled body part. Random per body part rolls damage for every enabled body part. Random body parts distributes wounds over a random subset.";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class Specific {name = "Specific damage to selected body parts"; value = 0;};
					class RandomEach {name = "Random damage to selected body parts"; value = 1;};
					class RandomParts {name = "Random damage to random body parts"; value = 2;};
				};
			};

			class GVAR(aceDamageProjectileCategory)
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Projectile";
				description = "";
			};

			class GVAR(aceDamageProjectileType): Combo
			{
				property = QGVAR(aceDamageProjectileType);
				displayName = "Projectile Type";
				tooltip = "ACE projectile damage type. Use Custom first with the custom projectile field for modded types.";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class Bullet {name = "Bullet"; value = 0;};
					class Grenade {name = "Grenade"; value = 1;};
					class Explosive {name = "Explosive"; value = 2;};
					class Shell {name = "Shell"; value = 3;};
					class VehicleCrash {name = "Vehicle crash"; value = 4;};
					class Collision {name = "Collision"; value = 5;};
					class Backblast {name = "Backblast"; value = 6;};
					class Stab {name = "Stab"; value = 7;};
					class Punch {name = "Punch"; value = 8;};
					class Falling {name = "Falling"; value = 9;};
					class Ropeburn {name = "Rope burn"; value = 10;};
					class Burn {name = "Burn"; value = 11;};
					class Unknown {name = "Unknown"; value = 12;};
					class Custom {name = "Custom first"; value = 13;};
				};
			};

			class GVAR(aceDamageCustomProjectiles): Edit
			{
				property = QGVAR(aceDamageCustomProjectiles);
				displayName = "Custom Projectiles";
				tooltip = "Comma-separated custom projectile damage types. Random projectile can pick from these too.";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(aceDamageRandomProjectile): Checkbox
			{
				property = QGVAR(aceDamageRandomProjectile);
				displayName = "Random Projectile";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(aceDamageRandomProjectiles): Edit
			{
				property = QGVAR(aceDamageRandomProjectiles);
				displayName = "Random Projectile Pool";
				tooltip = "Optional comma-separated projectile types used by Random Projectile. Leave empty to use all known projectile types plus custom projectiles.";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(aceDamageWoundsCategory)
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Wounds";
				description = "";
			};

			class GVAR(aceDamageWoundCount): Edit
			{
				property = QGVAR(aceDamageWoundCount);
				displayName = "Wound Count";
				tooltip = "How many wounds are applied. For random body parts this is total wounds. Otherwise it is wounds per enabled body part.";
				typeName = "NUMBER";
				defaultValue = "1";
				validate = "number";
			};

			class GVAR(aceDamageRandomWoundCount): Checkbox
			{
				property = QGVAR(aceDamageRandomWoundCount);
				displayName = "Randomize Wound Count";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(aceDamageWoundCountMin): Edit
			{
				property = QGVAR(aceDamageWoundCountMin);
				displayName = "Min Random Wounds";
				tooltip = "Lower limit for randomized wound count.";
				typeName = "NUMBER";
				defaultValue = "1";
				validate = "number";
			};

			class GVAR(aceDamageWoundCountMax): Edit
			{
				property = QGVAR(aceDamageWoundCountMax);
				displayName = "Max Random Wounds";
				tooltip = "Random wound count rolls from Min Random Wounds to this number.";
				typeName = "NUMBER";
				defaultValue = "3";
				validate = "number";
			};

			class GVAR(aceDamageRandomBodyPartMin): Edit
			{
				property = QGVAR(aceDamageRandomBodyPartMin);
				displayName = "Min Random Body Parts";
				tooltip = "Lower limit for randomized body part count. Ignored when Max Random Body Parts is 0.";
				typeName = "NUMBER";
				defaultValue = "1";
				validate = "number";
			};

			class GVAR(aceDamageRandomBodyPartMax): Edit
			{
				property = QGVAR(aceDamageRandomBodyPartMax);
				displayName = "Max Random Body Parts";
				tooltip = "Only used by Random damage to random body parts. 0 means all enabled body parts and ignores Min Random Body Parts.";
				typeName = "NUMBER";
				defaultValue = "1";
				validate = "number";
			};

			class GVAR(aceDamageRandomDamageMin): Edit
			{
				property = QGVAR(aceDamageRandomDamageMin);
				displayName = "Min Random Damage";
				tooltip = "Lower limit used when randomizing damage values.";
				typeName = "NUMBER";
				defaultValue = "0";
				validate = "number";
			};

			class GVAR(aceDamageRandomDamageMax): Edit
			{
				property = QGVAR(aceDamageRandomDamageMax);
				displayName = "Max Random Damage";
				tooltip = "Random damage rolls from Min Random Damage to this number.";
				typeName = "NUMBER";
				defaultValue = "0.8";
				validate = "number";
			};

			class GVAR(aceDamageOverrideInvulnerability): Checkbox
			{
				property = QGVAR(aceDamageOverrideInvulnerability);
				displayName = "Override Invulnerability";
				typeName = "BOOL";
				defaultValue = "true";
			};

			class GVAR(aceDamageForceDeath): Checkbox
			{
				property = QGVAR(aceDamageForceDeath);
				displayName = "Force Death";
				tooltip = "Kills the unit after the configured ACE damage and optional force are applied.";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(aceDamageBodyPartsCategory)
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Body Parts";
				description = "";
			};

			class GVAR(aceDamageUseHead): Checkbox {property = QGVAR(aceDamageUseHead); displayName = "Use Head"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageHead): Edit {property = QGVAR(aceDamageHead); displayName = "Head Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};
			class GVAR(aceDamageUseBody): Checkbox {property = QGVAR(aceDamageUseBody); displayName = "Use Body"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageBody): Edit {property = QGVAR(aceDamageBody); displayName = "Body Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};
			class GVAR(aceDamageUseLeftArm): Checkbox {property = QGVAR(aceDamageUseLeftArm); displayName = "Use Left Arm"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageLeftArm): Edit {property = QGVAR(aceDamageLeftArm); displayName = "Left Arm Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};
			class GVAR(aceDamageUseRightArm): Checkbox {property = QGVAR(aceDamageUseRightArm); displayName = "Use Right Arm"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageRightArm): Edit {property = QGVAR(aceDamageRightArm); displayName = "Right Arm Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};
			class GVAR(aceDamageUseLeftLeg): Checkbox {property = QGVAR(aceDamageUseLeftLeg); displayName = "Use Left Leg"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageLeftLeg): Edit {property = QGVAR(aceDamageLeftLeg); displayName = "Left Leg Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};
			class GVAR(aceDamageUseRightLeg): Checkbox {property = QGVAR(aceDamageUseRightLeg); displayName = "Use Right Leg"; typeName = "BOOL"; defaultValue = "true";};
			class GVAR(aceDamageRightLeg): Edit {property = QGVAR(aceDamageRightLeg); displayName = "Right Leg Damage"; typeName = "NUMBER"; defaultValue = "0.4"; validate = "number";};

			class GVAR(aceDamageForceCategory)
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Force";
				description = "";
			};

			class GVAR(aceDamageApplyForce): Checkbox
			{
				property = QGVAR(aceDamageApplyForce);
				displayName = "Apply Force";
				tooltip = "Enables the physical ragdoll shove after damage. Useful when forcing death so units do not all fall into the same static pose.";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(aceDamageRandomForce): Checkbox
			{
				property = QGVAR(aceDamageRandomForce);
				displayName = "Randomize Force";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(aceDamageForceVector): Edit
			{
				property = QGVAR(aceDamageForceVector);
				displayName = "Force Vector";
				tooltip = "Array applied as velocity kick, e.g. [0,3,4]. Leave empty for a modest random infantry ragdoll shove.";
				typeName = "STRING";
				defaultValue = "'[0,3,4]'";
			};

			class GVAR(aceDamageForceMin): Edit
			{
				property = QGVAR(aceDamageForceMin);
				displayName = "Min Random Force";
				tooltip = "Minimum random force magnitude when random force is enabled.";
				typeName = "NUMBER";
				defaultValue = "0";
				validate = "number";
			};

			class GVAR(aceDamageForceMax): Edit
			{
				property = QGVAR(aceDamageForceMax);
				displayName = "Max Random Force";
				tooltip = "Random force rolls each axis between the min and max magnitudes.";
				typeName = "NUMBER";
				defaultValue = "4";
				validate = "number";
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a unit to this module to apply ACE medical damage.";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any unit to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 1;
				synced[] = {"AnyBrain"};
			};
		};
	};

	class GVAR(aiStationary): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Turn AI Stationary";
		function = QEFUNC(modules,stationaryAIInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(aiStationaryGroup): Combo
  			{
					property = QGVAR(aiStationaryGroupCombo);
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

	class GVAR(ambientAnimationMP): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Ambient Animation MP";
		function = QEFUNC(modules,ambientAnimationMP);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(ambientAnimationMPSelection): Combo
  			{
				property = QGVAR(ambientAnimationMPSelectionCombo);
				displayName = "Choose an Ambient Animation";
				typeName = "NUMBER";
				defaultValue = "0";
				expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'ambient'] call mmm_modules_fnc_previewAnimation3DEN;};";
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

			class GVAR(ambientAnimationMPSnapObject): Edit
  			{
				property = QGVAR(ambientAnimationMPSnapObjectEdit);
				displayName = "Assign an Object to snap to!";
				tooltip = "Leave empty if you don't want to snap to an object";
				expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'ambient'] call mmm_modules_fnc_previewAnimation3DEN;};";
			};
			
			class GVAR(ambientAnimationMPDamage): Combo
  			{
				property = QGVAR(ambientAnimationMPDamageCombo);
				displayName = "Allow Damage";
				typeName = "NUMBER";
				defaultValue = "0";
				expression = "_this setVariable ['%s', _value];";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class GVAR(ambientAnimationMPDelay): Edit
  			{
				property = QGVAR(ambientAnimationMPDelayEdit);
				displayName = "Random Start Delay";
				tooltip = "Maximum random start delay in seconds. Set to 0 to start all synced units at the same time.";
				typeName = "NUMBER";
				defaultValue = "0.5";
				validate = "number";
				expression = "_this setVariable ['%s', _value];";
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

	class GVAR(animation): Module_F
	{
		category = QGVAR(Modules);
		displayName = "SwitchMove Animation";
		function = QEFUNC(modules,animation);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(animationSelection): Combo
  			{
					property = QGVAR(animationSelectionCombo);
					displayName = "Choose an Animation";
					typeName = "NUMBER";
					defaultValue = "0";
					expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'switchMove'] call mmm_modules_fnc_previewAnimation3DEN;};";
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
						class Injured_lying_5 {name = "Lying Injured"; value = 26;};
						class Injured_lyingarm_1 {name = "Lying Injured Arm"; value = 27;};
						class Injured_lyingchest_2 {name = "Lying Injured Chest"; value = 28;};
						class Injured_lyinghead_3 {name = "Lying Injured Head"; value = 29;};
						class Injured_lyingleg_4 {name = "Lying Injured Leg"; value = 30;};
						class Injured_Weapon_Arm {name = "Lying Injured Arm (Weapon)"; value = 31;};
						class Injured_Weapon_Chest {name = "Lying Injured Chest (Weapon)"; value = 32;};
						class Injured_Weapon_Head {name = "Lying Injured Head (Weapon)"; value = 33;};
						class Injured_Weapon_Leg {name = "Lying Injured Leg (Weapon)"; value = 34;};
						class Injured_Weapon_Angry {name = "Lying Injured Angry"; value = 35;};
						class Injured_Weapon_Coughing {name = "Lying Injured Coughing (Weapon)"; value = 36;};
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

			class GVAR(animationCustom): Edit
  			{
				property = QGVAR(animationCustomEdit);
				displayName = "Custom Animation";
				tooltip = "Optional animation name. If set, this overrides the selected animation. Quoted input and comma-separated lists are accepted; only the first entry is used.";
				expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'switchMove'] call mmm_modules_fnc_previewAnimation3DEN;};";
			};
			
			class GVAR(animationDamage): Combo
  			{
				property = QGVAR(animationDamageCombo);
				displayName = "Allow Damage";
				typeName = "NUMBER";
				defaultValue = "0";
				expression = "_this setVariable ['%s', _value];";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class GVAR(animationDelay): Edit
  			{
				property = QGVAR(animationDelayEdit);
				displayName = "Random Start Delay";
				tooltip = "Maximum random start delay in seconds. Set to 0 to start all synced units at the same time.";
				typeName = "NUMBER";
				defaultValue = "0.5";
				validate = "number";
				expression = "_this setVariable ['%s', _value];";
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

	class GVAR(baseMedic): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Base Medic";
		function = QEFUNC(modules,baseMedicInit);
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

	class GVAR(playMoveAnimation): Module_F
	{
		category = QGVAR(Modules);
		displayName = "PlayMove Animation";
		function = QEFUNC(modules,playMoveAnimation);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(playMoveAnimationSelection): Combo
  			{
				property = QGVAR(playMoveAnimationSelectionCombo);
				displayName = "Choose an Animation";
				typeName = "NUMBER";
				defaultValue = "0";
				expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'playMove'] call mmm_modules_fnc_previewAnimation3DEN;};";
				class Values
				{
					class Idle_Unarmed {name = "Idle Unarmed"; value = 0;};
					class Exercise_Pushup {name = "Exercise Pushup"; value = 1;};
					class Exercise_Kata {name = "Exercise Kata"; value = 2;};
					class Exercise_KneeBend_A {name = "Exercise Knee Bend A"; value = 3;};
					class Exercise_KneeBend_B {name = "Exercise Knee Bend B"; value = 4;};
				};
			};

			class GVAR(playMoveAnimationCustom): Edit
  			{
				property = QGVAR(playMoveAnimationCustomEdit);
				displayName = "Custom Animation";
				tooltip = "Optional animation name. If set, this overrides the selected animation. Quoted input and comma-separated lists are accepted; only the first entry is used.";
				expression = "_this setVariable ['%s', _value]; if (is3DEN) then {[_this, 'playMove'] call mmm_modules_fnc_previewAnimation3DEN;};";
			};

			class GVAR(playMoveAnimationDamage): Combo
  			{
				property = QGVAR(playMoveAnimationDamageCombo);
				displayName = "Allow Damage";
				typeName = "NUMBER";
				defaultValue = "0";
				expression = "_this setVariable ['%s', _value];";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class GVAR(playMoveAnimationDelay): Edit
  			{
				property = QGVAR(playMoveAnimationDelayEdit);
				displayName = "Random Start Delay";
				tooltip = "Maximum random start delay in seconds. Set to 0 to start all synced units at the same time.";
				typeName = "NUMBER";
				defaultValue = "0.5";
				validate = "number";
				expression = "_this setVariable ['%s', _value];";
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync an AI Unit to this module to make it play the selected playMove animation";
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

	class GVAR(mobileHQ): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Mobile HQ";
		function = QEFUNC(modules,mobileHQInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(mobileHQName): Edit
			{
				property = QGVAR(mobileHQName);
				displayName = "Respawn Name";
				tooltip = "Optional custom name for the MHQ respawn position. Leave empty for Mobile HQ 1, Mobile HQ 2, ...";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(mobileHQSide): Combo
			{
				property = QGVAR(mobileHQSide);
				displayName = "Respawn Side";
				tooltip = "Side that receives this MHQ respawn position.";
				typeName = "STRING";
				defaultValue = "'west'";

				class Values
				{
					class West {name = "BLUFOR"; value = "west";};
					class East {name = "OPFOR"; value = "east";};
					class Independent {name = "Independent"; value = "independent";};
					class Civilian {name = "Civilian"; value = "civilian";};
				};
			};

			class GVAR(mobileHQAlwaysDeployed): Checkbox
			{
				property = QGVAR(mobileHQAlwaysDeployed);
				displayName = "Always Deployed";
				tooltip = "This MHQ is always deployed, regardless of the global deployment setting.";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync an object, unit, or vehicle to make it a Mobile HQ.";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] =	{"Synchronise any object, unit, or vehicle to this module."};
				position = 0;
				direction = 0;
				optional = 0;
				duplicate = 0;
				synced[] = {"AnyStaticObject", "AnyVehicle", "AnyBrain"};
			};
		};
	};

	class GVAR(randomizeGear): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Full";
		function = QEFUNC(modules,randomizeGearInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			// Backpacks
			class GVAR(backpacksCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Backpacks Attributes";
				description = "";
			};

			class GVAR(randomizeGearBackpacksRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearBackpacksRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the backpacks randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearBackpacksForce): Checkbox 
			{
				property = QGVAR(randomizeGearBackpacksForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds backpacks even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearBackpacksChance): Edit
			{
				property = QGVAR(randomizeGearBackpacksChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the backpacks being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no backpacks being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearBackpacksContent): Edit
			{
				property = QGVAR(randomizeGearBackpacksContent);
				displayName = "Classnames";
				tooltip = "Enter classnames of Backpacks. \n\nE.g. B_AssaultPack_blk,B_Bergen_blk,B_Carryall_blk...";
				typeName = "STRING";
				defaultValue = "''";
			};

			//Goggles
			class GVAR(gogglesCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Goggles Attributes";
				description = "";
			};

			class GVAR(randomizeGearGogglesRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearGogglesRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the vests randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearGogglesForce): Checkbox 
			{
				property = QGVAR(randomizeGearGogglesForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds vests even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearGogglesChance): Edit
			{
				property = QGVAR(randomizeGearGogglesChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearGogglesContent): Edit
			{
				property = QGVAR(randomizeGearGogglesContentEdit);
				tooltip = "Enter classnames of Goggles. \n\nE.g. G_Balaclava_blk,G_Bandanna_blk,G_Shades_Black...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			// Headgear
			class GVAR(headgearCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Headgear Attributes";
				description = "";
			};

			class GVAR(randomizeGearHeadgearRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearHeadgearRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the headgear randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearHeadgearForce): Checkbox 
			{
				property = QGVAR(randomizeGearHeadgearForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds headgear even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearHeadgearChance): Edit
			{
				property = QGVAR(randomizeGearHeadgearChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the headgear being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no headgear being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearHeadgearContent): Edit
			{
				property = QGVAR(randomizeGearHeadgearContentEdit);
				tooltip = "Enter classnames of Headgear. \n\nE.g. H_Bandanna_blu,H_Booniehat_dirty,H_Hat_camo...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			// Uniforms
			class GVAR(uniformsCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Uniforms Attributes";
				description = "";
			};

			class GVAR(randomizeGearUniformsRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearUniformsRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the uniforms randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearUniformsForce): Checkbox 
			{
				property = QGVAR(randomizeGearUniformsForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds uniforms even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearUniformsChance): Edit
			{
				property = QGVAR(randomizeGearUniformsChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the uniforms being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no uniforms being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearUniformsContent): Edit
			{
				property = QGVAR(randomizeGearUniformsContent);
				tooltip = "Enter classnames of Uniforms. \n\nE.g. U_BG_Guerilla1_1,U_B_CombatUniform_mcam_tshirt,U_B_GEN_Commander_F...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};
			
			// Vests
			class GVAR(vestsCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Vests Attributes";
				description = "";
			};

			class GVAR(randomizeGearVestsRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearVestsRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the vests randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearVestsForce): Checkbox 
			{
				property = QGVAR(randomizeGearVestsForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds vests even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearVestsChance): Edit
			{
				property = QGVAR(randomizeGearVestsChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearVestsContent): Edit
			{
				property = QGVAR(randomizeGearVestsContent);
				tooltip = "Enter classnames of Vests. \n\nE.g. V_BandollierB_blk,V_Chestrig_blk,V_PlateCarrier1_blk...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			// Primary Weapon
			class GVAR(primaryCategory) {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Primary Weapons Attributes";
				description = "";
			};
			class GVAR(randomizeGearWeaponsPrimaryRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsRandomizePrimaryCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the primary weapon randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryForce): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsPrimaryForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds a primary weapon even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryContentEdit);
				tooltip = "Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeRandomizeCheckbox);
				displayName = "[Scope] Randomize";
				tooltip = "Activates the scope randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeChance);
				displayName = "[Scope] Empty Chance";
				tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeContentEdit);
				tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
				displayName = "[Scope] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentRailRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailRandomizeCheckbox);
				displayName = "[Rail] Randomize";
				tooltip = "Activates the rail attachment randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentRailChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailChance);
				displayName = "[Rail] Empty Chance";
				tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentRailContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailContentEdit);
				tooltip = "Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty";
				displayName = "[Rail] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleRandomizeCheckbox);
				displayName = "[Muzzle] Randomize";
				tooltip = "Activates the muzzle randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleChanceEdit);
				displayName = "[Muzzle] Empty Chance";
				tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleContentEdit);
				tooltip = "Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
				displayName = "[Muzzle] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodRandomizeCheckbox);
				displayName = "[Bipod] Randomize";
				tooltip = "Activates the bipod randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodChanceEdit);
				displayName = "[Bipod] Empty Chance";
				tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodContentEdit);
				tooltip = "Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
				displayName = "[Bipod] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			// Sidearm Weapon
			class GVAR(sidearmCategory) {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Sidearm Weapons Attributes";
				description = "";
			};
			class GVAR(randomizeGearWeaponsSidearmRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the sidearm weapon randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmForce): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds a sidearm weapon even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmContentEdit);
				tooltip = "Enter classnames of Weapons. \n\nE.g. hgun_P07_blk_F,hgun_Rook40_F,hgun_P07_F...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentScopeRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeRandomizeCheckbox);
				displayName = "[Scope] Randomize";
				tooltip = "Activates the scope randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentScopeChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeChanceEdit);
				displayName = "[Scope] Empty Chance";
				tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentScopeContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeContentEdit);
				tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
				displayName = "[Scope] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentRailRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailRandomizeCheckbox);
				displayName = "[Rail] Randomize";
				tooltip = "Activates the rail attachment randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentRailChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailChanceEdit);
				displayName = "[Rail] Empty Chance";
				tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentRailContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailContentEdit);
				tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
				displayName = "[Rail] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleRandomizeCheckbox);
				displayName = "[Muzzle] Randomize";
				tooltip = "Activates the muzzle randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleChanceEdit);
				displayName = "[Muzzle] Empty Chance";
				tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleContentEdit);
				tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
				displayName = "[Muzzle] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentBipodRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodRandomizeCheckbox);
				displayName = "[Bipod] Randomize";
				tooltip = "Activates the bipod randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentBipodChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodChanceEdit);
				displayName = "[Bipod] Empty Chance";
				tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSidearmAttachmentBipodContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodContentEdit);
				tooltip = "Enter classnames of bipods. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
				displayName = "[Bipod] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			// Secondary Weapon
			class GVAR(secondaryCategory) {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Secondary Weapons Attributes";
				description = "";
			};
			class GVAR(randomizeGearWeaponsSecondaryRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the secondary weapon randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryForce): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds a secondary weapon even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryContentEdit);
				tooltip = "Enter classnames of Weapons. \n\nE.g. launch_NLAW_F,launch_RPG32_F,launch_MRAWS_green_F...";
				displayName = "Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeRandomizeCheckbox);
				displayName = "[Scope] Randomize";
				tooltip = "Activates the scope randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeChanceEdit);
				displayName = "[Scope] Empty Chance";
				tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeContentEdit);
				tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
				displayName = "[Scope] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentRailRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailRandomizeCheckbox);
				displayName = "[Rail] Randomize";
				tooltip = "Activates the rail attachment randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentRailChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailChanceEdit);
				displayName = "[Rail] Empty Chance";
				tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentRailContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailContentEdit);
				tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
				displayName = "[Rail] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleRandomizeCheckbox);
				displayName = "[Muzzle] Randomize";
				tooltip = "Activates the muzzle randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleChanceEdit);
				displayName = "[Muzzle] Empty Chance";
				tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleContentEdit);
				tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
				displayName = "[Muzzle] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodRandomizeCheckbox);
				displayName = "[Bipod] Randomize";
				tooltip = "Activates the bipod randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodChance): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodChanceEdit);
				displayName = "[Bipod] Empty Chance";
				tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodContent): Edit
			{
				property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodContentEdit);
				tooltip = "Enter classnames of bipods. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
				displayName = "[Bipod] Classnames";
				typeName = "STRING";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Sync a Unit to this module to randomize its gear!";
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

	class GVAR(randomizeGearBackpacks): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Backpacks";
		function = QEFUNC(modules,randomizeGearBackpacksInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(backpacksCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Backpacks Attributes";
				description = "";
			};

			class GVAR(randomizeGearBackpacksRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearBackpacksRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the backpacks randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearBackpacksForce): Checkbox 
			{
				property = QGVAR(randomizeGearBackpacksForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds backpacks even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearBackpacksChance): Edit
			{
				property = QGVAR(randomizeGearBackpacksChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the backpacks being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no backpacks being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearBackpacksContent): Edit
			{
				property = QGVAR(randomizeGearBackpacksContent);
				displayName = "Classnames";
				tooltip = "Enter classnames of Backpacks. \n\nE.g. B_AssaultPack_blk,B_Bergen_blk,B_Carryall_blk...";
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

	class GVAR(randomizeGearGoggles): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Goggles";
		function = QEFUNC(modules,randomizeGearGogglesInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(gogglesCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Goggles Attributes";
				description = "";
			};

			class GVAR(randomizeGearGogglesRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearGogglesRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the vests randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearGogglesForce): Checkbox 
			{
				property = QGVAR(randomizeGearGogglesForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds vests even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearGogglesChance): Edit
			{
				property = QGVAR(randomizeGearGogglesChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearGogglesContent): Edit
			{
				property = QGVAR(randomizeGearGogglesContentEdit);
				tooltip = "Enter classnames of Goggles. \n\nE.g. G_Balaclava_blk,G_Bandanna_blk,G_Shades_Black...";
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

	class GVAR(randomizeGearHeadgear): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Headgear";
		function = QEFUNC(modules,randomizeGearHeadgearInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(headgearCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Headgear Attributes";
				description = "";
			};

			class GVAR(randomizeGearHeadgearRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearHeadgearRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the headgear randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearHeadgearForce): Checkbox 
			{
				property = QGVAR(randomizeGearHeadgearForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds headgear even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearHeadgearChance): Edit
			{
				property = QGVAR(randomizeGearHeadgearChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the headgear being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no headgear being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearHeadgearContent): Edit
			{
				property = QGVAR(randomizeGearHeadgearContentEdit);
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

	class GVAR(randomizeGearUniforms): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Uniforms";
		function = QEFUNC(modules,randomizeGearUniformsInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(uniformsCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Uniforms Attributes";
				description = "";
			};

			class GVAR(randomizeGearUniformsRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearUniformsRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the uniforms randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearUniformsForce): Checkbox 
			{
				property = QGVAR(randomizeGearUniformsForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds uniforms even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearUniformsChance): Edit
			{
				property = QGVAR(randomizeGearUniformsChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the uniforms being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no uniforms being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearUniformsContent): Edit
			{
				property = QGVAR(randomizeGearUniformsContent);
				tooltip = "Enter classnames of Uniforms. \n\nE.g. U_BG_Guerilla1_1,U_B_CombatUniform_mcam_tshirt,U_B_GEN_Commander_F...";
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

	class GVAR(randomizeGearVests): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Vests";
		function = QEFUNC(modules,randomizeGearVestsInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(vestsCategory) 
			{
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Vests Attributes";
				description = "";
			};

			class GVAR(randomizeGearVestsRandomize): Checkbox 
			{
				property = QGVAR(randomizeGearVestsRandomizeCheckbox);
				displayName = "Randomize";
				tooltip = "Activate the vests randomization";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearVestsForce): Checkbox 
			{
				property = QGVAR(randomizeGearVestsForceCheckbox);
				displayName = "Force adding";
				tooltip = "Adds vests even if the unit did not have one before";
				typeName = "BOOL";
				defaultValue = "false";
			};

			class GVAR(randomizeGearVestsChance): Edit
			{
				property = QGVAR(randomizeGearVestsChanceEdit);
				displayName = "Empty Chance";
				tooltip = "Enter the chance for the vests being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no vests being added";
				typeName = "NUMBER";
				defaultValue = "0";
			};

			class GVAR(randomizeGearVestsContent): Edit
			{
				property = QGVAR(randomizeGearVestsContent);
				tooltip = "Enter classnames of Vests. \n\nE.g. V_BandollierB_blk,V_Chestrig_blk,V_PlateCarrier1_blk...";
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

	class GVAR(randomizeGearWeapons): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Gear Randomizer: Weapons";
		function = QEFUNC(modules,randomizeGearWeaponsInit);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			// Primary Weapon
				class GVAR(primaryCategory) {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Primary Weapons Attributes";
					description = "";
				};
				class GVAR(randomizeGearWeaponsPrimaryRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsRandomizePrimaryCheckbox);
					displayName = "Randomize";
					tooltip = "Activate the primary weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryForce): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsPrimaryForceCheckbox);
					displayName = "Force adding";
					tooltip = "Adds a primary weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryContentEdit);
					tooltip = "Enter classnames of Weapons. \n\nE.g. arifle_MX_F,arifle_MX_Black_F,arifle_MXC_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeRandomizeCheckbox);
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeChance);
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentScopeContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentScopeContentEdit);
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentRailRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailRandomizeCheckbox);
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentRailChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailChance);
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentRailContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentRailContentEdit);
					tooltip = "Enter classnames of rail attachments. E.g. acc_pointer_IR,acc_flashlight,saber_light_lxWS...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleRandomizeCheckbox);
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleChanceEdit);
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentMuzzleContentEdit);
					tooltip = "Enter classnames of muzzles. E.g. muzzle_snds_M,muzzle_snds_m_khk_F,suppressor_l_lush_lxWS...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodRandomizeCheckbox);
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodChanceEdit);
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsPrimaryAttachmentBipodContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsPrimaryAttachmentBipodContentEdit);
					tooltip = "Enter classnames of bipods. E.g. bipod_01_F_khk,bipod_03_F_blk,bipod_01_F_mtp...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
					displayName = "[Bipod] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			// Sidearm Weapon
				class GVAR(sidearmCategory) {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Sidearm Weapons Attributes";
					description = "";
				};
				class GVAR(randomizeGearWeaponsSidearmRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmRandomizeCheckbox);
					displayName = "Randomize";
					tooltip = "Activate the sidearm weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmForce): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmForceCheckbox);
					displayName = "Force adding";
					tooltip = "Adds a sidearm weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmContentEdit);
					tooltip = "Enter classnames of Weapons. \n\nE.g. hgun_P07_blk_F,hgun_Rook40_F,hgun_P07_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentScopeRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeRandomizeCheckbox);
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentScopeChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeChanceEdit);
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentScopeContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentScopeContentEdit);
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentRailRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailRandomizeCheckbox);
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentRailChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailChanceEdit);
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentRailContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentRailContentEdit);
					tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleRandomizeCheckbox);
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleChanceEdit);
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentMuzzleContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentMuzzleContentEdit);
					tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentBipodRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodRandomizeCheckbox);
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentBipodChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodChanceEdit);
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSidearmAttachmentBipodContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSidearmAttachmentBipodContentEdit);
					tooltip = "Enter classnames of bipods. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Bipod Attachment Slot will be Empty";
					displayName = "[Bipod] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

			// Secondary Weapon
				class GVAR(secondaryCategory) {
					data = "AttributeSystemSubcategory";
					control = "SubCategory";
					displayName = "Secondary Weapons Attributes";
					description = "";
				};
				class GVAR(randomizeGearWeaponsSecondaryRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryRandomizeCheckbox);
					displayName = "Randomize";
					tooltip = "Activate the secondary weapon randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryForce): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryForceCheckbox);
					displayName = "Force adding";
					tooltip = "Adds a secondary weapon even if the unit did not have one before";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryContentEdit);
					tooltip = "Enter classnames of Weapons. \n\nE.g. launch_NLAW_F,launch_RPG32_F,launch_MRAWS_green_F...";
					displayName = "Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeRandomizeCheckbox);
					displayName = "[Scope] Randomize";
					tooltip = "Activates the scope randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeChanceEdit);
					displayName = "[Scope] Empty Chance";
					tooltip = "Enter the chance for the scope being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no scope being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentScopeContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentScopeContentEdit);
					tooltip = "Enter classnames of scopes. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Scope Attachment Slot will be Empty";
					displayName = "[Scope] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentRailRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailRandomizeCheckbox);
					displayName = "[Rail] Randomize";
					tooltip = "Activates the rail attachment randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentRailChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailChanceEdit);
					displayName = "[Rail] Empty Chance";
					tooltip = "Enter the chance for the rail attachment being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no rail attachment being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentRailContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentRailContentEdit);
					tooltip = "Enter classnames of rail attachments. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Rail Attachment Slot will be Empty";
					displayName = "[Rail] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleRandomizeCheckbox);
					displayName = "[Muzzle] Randomize";
					tooltip = "Activates the muzzle randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleChanceEdit);
					displayName = "[Muzzle] Empty Chance";
					tooltip = "Enter the chance for the muzzle being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no muzzle being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentMuzzleContentEdit);
					tooltip = "Enter classnames of muzzles. E.g. optic_ACO_grn,optic_ACO_grn,optic_Hamr...\n\nIf left Empty the Muzzle Attachment Slot will be Empty";
					displayName = "[Muzzle] Classnames";
					typeName = "STRING";
					defaultValue = "''";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodRandomize): Checkbox 
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodRandomizeCheckbox);
					displayName = "[Bipod] Randomize";
					tooltip = "Activates the bipod randomization";
					typeName = "BOOL";
					defaultValue = "false";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodChance): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodChanceEdit);
					displayName = "[Bipod] Empty Chance";
					tooltip = "Enter the chance for the bipod being empty \n\nEnter a value between 0 and 1.\nE.g. 0.4 = 40% chance of no bipod being added";
					typeName = "NUMBER";
					defaultValue = "0";
				};

				class GVAR(randomizeGearWeaponsSecondaryAttachmentBipodContent): Edit
				{
					property = QGVAR(randomizeGearWeaponsSecondaryAttachmentBipodContentEdit);
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

	class GVAR(spawnWreck): Module_F
	{
		category = QGVAR(Modules);
		displayName = "Spawn Vehicle as Wreck";
		function = QEFUNC(modules,spawnWreck);
		functionPriority = 10;
		isDisposable = 0;
		is3DEN = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		scope = 2;

		class Attributes: AttributesBase
		{
			class GVAR(spawnWreckACECookingOff): Combo
  			{
				property = QGVAR(spawnWreckACECookingOffCombo);
				displayName = "ACE Cook off";
				typeName = "NUMBER";
				defaultValue = "0";
				class Values
				{
					class answer_no	{name = "No"; value = 0;};
					class answer_yes	{name = "Yes";	value = 1;};
				};
			};

			class GVAR(spawnWreckDestroyEffect): Combo
  			{
				property = QGVAR(spawnWreckDestroyEffectCombo);
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
};
