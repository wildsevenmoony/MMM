/*
 * Author: Moony
 * Randomizes the primary weapon, sidearm and secondary weapon of the unit. Can also randomize the attachments of these three weapons 
 * (Attachments Randomization only works if weapon gets randomized) 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * 1: Enable Primary Weapon Randomization <BOOL>
 * 2: Classnames for randomization <STRING>
 * 3: Enable Primary Scope Randomization <BOOL>
 * 4: Chance of Primary Scope being empty <Number>
 * 5: Classnames for Primary Scope randomization <String>
 * 6: Enable Primary Rail Attachment Randomization <BOOL>
 * 7: Chance of Primary Rail Attachment being empty <Number>
 * 8: Classnames for Primary Rail Attachment randomization <String>
 * 9: Enable Primary Muzzle Randomization <BOOL>
 * 10: Chance of Primary Muzzle being empty <Number>
 * 11: Classnames for Primary Muzzle randomization <String>
 * 12: Enable Primary Bipod Randomization <BOOL>
 * 13: Chance of Primary Bipod being empty <Number>
 * 14: Classnames for Primary Bipod randomization <String>
 * 15: Force adding Primary Weapon <BOOL>
 * 16: Enable Sidearm Weapon Randomization <BOOL>
 * 17: Classnames for randomization <STRING>
 * 18: Enable Sidearm Scope Randomization <BOOL>
 * 19: Chance of Sidearm Scope being empty <Number>
 * 20: Classnames for Sidearm Scope randomization <String>
 * 21: Enable Sidearm Rail Attachment Randomization <BOOL>
 * 22: Chance of Sidearm Rail Attachment being empty <Number>
 * 23: Classnames for Sidearm Rail Attachment randomization <String>
 * 24: Enable Sidearm Muzzle Randomization <BOOL>
 * 25: Chance of Sidearm Muzzle being empty <Number>
 * 26: Classnames for Sidearm Muzzle randomization <String>
 * 27: Enable Sidearm Bipod Randomization <BOOL>
 * 28: Chance of Sidearm Bipod being empty <Number>
 * 29: Classnames for Sidearm Bipod randomization <String>
 * 30: Enable Secondary Weapon Randomization <BOOL>
 * 31: Classnames for randomization <STRING>
 * 32: Enable Secondary Scope Randomization <BOOL>
 * 33: Force Adding Secondary Scope <BOOL>
 * 34: Chance of Secondary Scope being empty <Number>
 * 35: Classnames for Secondary Scope randomization <String>
 * 36: Enable Secondary Rail Attachment Randomization <BOOL>
 * 37: Force Adding Secondary Rail Attachment <BOOL>
 * 38: Chance of Secondary Rail Attachment being empty <Number>
 * 39: Classnames for Secondary Rail Attachment randomization <String>
 * 40: Enable Secondary Muzzle Randomization <BOOL>
 * 41: Force Adding Secondary Muzzle <BOOL>
 * 42: Chance of Secondary Muzzle being empty <Number>
 * 43: Classnames for Secondary Muzzle randomization <String>
 * 44: Enable Secondary Bipod Randomization <BOOL>
 * 45: Force Adding Secondary Bipod <BOOL>
 * 46: Chance of Secondary Bipod being empty <Number>
 * 47: Classnames for Secondary Bipod randomization <String>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true, true,"arifle_MX_khk_F,srifle_DMR_07_blk_F,arifle_MSBS65_black_F", true,0,"optic_SOS,optic_NVS,ACE_optic_LRPS_2D", true,0,"acc_pointer_IR,EF_acc_pointer_IR_coy,saber_light_ir_khaki_lxWS", true,0,"muzzle_snds_H_khk_F,muzzle_snds_65_TI_ghex_F,suppressor_65_sand_RF", true,0,"bipod_02_F_arid,bipod_01_F_snd", true, true, "hgun_Pistol_heavy_01_F,hgun_Pistol_heavy_01_green_F,hgun_Glock19_RF", true,0,"optic_MRD_black,ef_optic_microsight_pistol_coy,optic_MRD_tan_RF", true,0,"acc_flashlight_pistol,acc_pointer_IR_pistol_RF", true,0,"muzzle_snds_L", true,0,"", true, true, "launch_NLAW_F,launch_PSRL1_black_RF,launch_RPG32_F", true,0,"optic_SOS,optic_NVS,ACE_optic_LRPS_2D", true,0,"", true,0,"", true,0,""] call mmm_modules_fnc_randomizeGearWeapons
 *
 * (See, its not made for calling it like this!)
 *
 * Public: Yes
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [
	"_unit",
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
	"_contentSecondaryBipod"
];

// Waits till other randomizations have happened
private _flags = [
    QGVAR(randomizationBackpacksDone),
    QGVAR(randomizationHeadgearDone),
    QGVAR(randomizationUniformsDone),
    QGVAR(randomizationVestsDone),
    QGVAR(randomizationGogglesDone)
];

// Filter which ones exist
private _activeFlags = _flags select {
    !isNil { _unit getVariable _x }
};

// Wait until all the ones that exist are true
waitUntil {
    {
        _unit getVariable [_x, false]
    } count _activeFlags == count _activeFlags
};

// Randomizes Primary Weapon if enabled
if (_randomizePrimary && ((_forcePrimary) || (!_forcePrimary && (primaryWeapon _unit) != ""))) then {
	private _weaponPrimaryArray = [_contentPrimary] call MMB_fnc_parseClassnameList;

	private _weaponPrimary = selectRandom _weaponPrimaryArray;
	private _compatibleAmmoPrimary = compatibleMagazines [_weaponPrimary, "this"];
	private _ammoPrimary = if (_compatibleAmmoPrimary isEqualTo []) then {""} else {_compatibleAmmoPrimary select 0};

	// Get all Primary Weapon Attachments
	private _getPrimaryAttachments = primaryWeaponItems _unit;

	// Get Primary Ammo Count
	private _getPrimaryAmmoCount = {_x in compatibleMagazines [primaryWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the primary weapon
	private _compatiblePrimaryMagazinesInventory = (magazines _unit) arrayIntersect (compatibleMagazines [primaryWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatiblePrimaryMagazinesInventory;

	// Remove Primary weapon
	_unit removeWeapon (primaryWeapon _unit);

	if (_weaponPrimary != "") then {
		// Add new Primary weapon
		_unit addWeapon _weaponPrimary;

		// Add Primary weapon Attachments from old weapons
		// Muzzle Attachment
		if (_randomizePrimaryMuzzle ) then {
			if (random 1 <= _chancePrimaryMuzzle || _contentPrimaryMuzzle isEqualTo "") then {
				_unit removePrimaryWeaponItem (_getPrimaryAttachments select 0);
			} else {
				private _weaponPrimaryAttachmentMuzzleArray = ([_contentPrimaryMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponPrimaryAttachmentMuzzle = selectRandom _weaponPrimaryAttachmentMuzzleArray;
				if (_weaponPrimaryAttachmentMuzzle != "") then {
					_unit addPrimaryWeaponItem _weaponPrimaryAttachmentMuzzle;
				};
			};
		} else {
			private _oldMuzzle = _getPrimaryAttachments select 0;
			if (_oldMuzzle != "") then {
				_unit addPrimaryWeaponItem _oldMuzzle;
			};
		};
	
		// Rail Attachment
		if (_randomizePrimaryRail) then {
			if (random 1 <= _chancePrimaryRail || _contentPrimaryRail isEqualTo "") then {
				_unit removePrimaryWeaponItem (_getPrimaryAttachments select 1);
			} else {
				private _weaponPrimaryAttachmentRailArray = ([_contentPrimaryRail] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponPrimaryAttachmentRail = selectRandom _weaponPrimaryAttachmentRailArray;
				if (_weaponPrimaryAttachmentRail != "") then {
					_unit addPrimaryWeaponItem _weaponPrimaryAttachmentRail;
				};
			};
		} else {
			private _oldRail = _getPrimaryAttachments select 1;
			if (_oldRail != "") then {
				_unit addPrimaryWeaponItem _oldRail;
			};
		};

		// Sight
		if (_randomizePrimaryScope) then {
			if (random 1 <= _chancePrimaryScope || _contentPrimaryScope isEqualTo "") then {
				_unit removePrimaryWeaponItem (_getPrimaryAttachments select 2);
			} else {
				private _weaponPrimaryAttachmentScopeArray = ([_contentPrimaryScope] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponPrimaryAttachmentScope = selectRandom _weaponPrimaryAttachmentScopeArray;
				if (_weaponPrimaryAttachmentScope != "") then {
					_unit addPrimaryWeaponItem _weaponPrimaryAttachmentScope;
				};
			};
		} else {
			private _oldScope = _getPrimaryAttachments select 2;
			if (_oldScope != "") then {
				_unit addPrimaryWeaponItem _oldScope;
			};
		};

		// Bipod
		if (_randomizePrimaryBipod) then {
			if (random 1 <= _chancePrimaryBipod || _contentPrimaryBipod isEqualTo "") then {
				_unit removePrimaryWeaponItem (_getPrimaryAttachments select 3);
			} else {
				private _weaponPrimaryAttachmentBipodArray = ([_contentPrimaryBipod] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponPrimaryAttachmentBipod = selectRandom _weaponPrimaryAttachmentBipodArray;
				if (_weaponPrimaryAttachmentBipod != "") then {
					_unit addPrimaryWeaponItem _weaponPrimaryAttachmentBipod;
				};
			};
		} else {
			private _oldBipod = _getPrimaryAttachments select 3;
			if (_oldBipod != "") then {
				_unit addPrimaryWeaponItem _oldBipod;
			};
		};

		// Magazine 
		if (_ammoPrimary != "") then {
			_unit addPrimaryWeaponItem _ammoPrimary;

			// Add Primary weapon Magazines 
			_unit addMagazines [_ammoPrimary, _getPrimaryAmmoCount];
		};
	};
};

// Randomizes Sidearm Weapon if enabled
if (_randomizeSidearm && ((_forceSidearm) || (!_forceSidearm && (handgunWeapon _unit) != ""))) then {
	private _weaponSidearmArray = [_contentSidearm] call MMB_fnc_parseClassnameList;
	private _weaponSidearm = selectRandom _weaponSidearmArray;
	private _compatibleAmmoSidearm = compatibleMagazines [_weaponSidearm, "this"];
	private _ammoSidearm = if (_compatibleAmmoSidearm isEqualTo []) then {""} else {_compatibleAmmoSidearm select 0};

	// Get all Sidearm Weapon Attachments
	private _getSidearmAttachments = handgunItems _unit;

	// Get Sidearm Ammo Count
	private _getSidearmAmmoCount = {_x in compatibleMagazines [handgunWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the sidearm weapon
	private _compatibleSidearmMagazinesInventory = (magazines _unit) arrayIntersect (compatibleMagazines [handgunWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatibleSidearmMagazinesInventory;
	// Remove Sidearm weapon
	_unit removeWeapon (handgunWeapon _unit);

	if (_weaponSidearm != "") then {
		// Add new Sidearm weapon
		_unit addWeapon _weaponSidearm;

		// Add Sidearm weapon Attachments from old weapons
		// Muzzle Attachment
		if (_randomizeSidearmMuzzle) then {
			if (random 1 <= _chanceSidearmMuzzle || _contentSidearmMuzzle isEqualTo "") then {
				_unit removeHandgunItem (_getSidearmAttachments select 0);
			} else {
				private _weaponSidearmAttachmentMuzzleArray = ([_contentSidearmMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSidearmAttachmentMuzzle = selectRandom _weaponSidearmAttachmentMuzzleArray;
				if (_weaponSidearmAttachmentMuzzle != "") then {
					_unit addHandgunItem _weaponSidearmAttachmentMuzzle;
				};
			};
		} else {
			private _oldMuzzle = _getSidearmAttachments select 0;
			if (_oldMuzzle != "") then {
				_unit addHandgunItem _oldMuzzle;
			};
		};
	
		// Rail Attachment
		if (_randomizeSidearmRail) then {
			if (random 1 <= _chanceSidearmRail || _contentSidearmRail isEqualTo "") then {
				_unit removeHandgunItem (_getSidearmAttachments select 1);
			} else {
				private _weaponSidearmAttachmentRailArray = ([_contentSidearmRail] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSidearmAttachmentRail = selectRandom _weaponSidearmAttachmentRailArray;
				if (_weaponSidearmAttachmentRail != "") then {
					_unit addHandgunItem _weaponSidearmAttachmentRail;
				};
			};
		} else {
			private _oldRail = _getSidearmAttachments select 1;
			if (_oldRail != "") then {
				_unit addHandgunItem _oldRail;
			};
		};

		// Sight
		if (_randomizeSidearmScope) then {
			if (random 1 <= _chanceSidearmScope || _contentSidearmScope isEqualTo "") then {
				_unit removeHandgunItem (_getSidearmAttachments select 2);
			} else {
				private _weaponSidearmAttachmentScopeArray = ([_contentSidearmScope] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSidearmAttachmentScope = selectRandom _weaponSidearmAttachmentScopeArray;
				if (_weaponSidearmAttachmentScope != "") then {
					_unit addHandgunItem _weaponSidearmAttachmentScope;
				};
			};
		} else {
			private _oldScope = _getSidearmAttachments select 2;
			if (_oldScope != "") then {
				_unit addHandgunItem _oldScope;
			};
		};

		// Bipod
		if (_randomizeSidearmBipod) then {
			if (random 1 <= _chanceSidearmBipod || _contentSidearmBipod isEqualTo "") then {
				_unit removeHandgunItem (_getSidearmAttachments select 3);
			} else {
				private _weaponSidearmAttachmentBipodArray = ([_contentSidearmBipod] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSidearmAttachmentBipod = selectRandom _weaponSidearmAttachmentBipodArray;
				if (_weaponSidearmAttachmentBipod != "") then {
					_unit addHandgunItem _weaponSidearmAttachmentBipod;
				};
			};
		} else {
			private _oldBipod = _getSidearmAttachments select 3;
			if (_oldBipod != "") then {
				_unit addHandgunItem _oldBipod;
			};
		};

		// Magazine 
		if (_ammoSidearm != "") then {
			_unit addHandgunItem _ammoSidearm;

			// Add Sidearm weapon Magazines 
			_unit addMagazines [_ammoSidearm, _getSidearmAmmoCount];
		};
	};
};

// Randomizes Secondary Weapon if enabled
if (_randomizeSecondary && ((_forceSecondary) || (!_forceSecondary && (secondaryWeapon _unit) != ""))) then {
	private _weaponSecondaryArray = [_contentSecondary] call MMB_fnc_parseClassnameList;
	private _weaponSecondary = selectRandom _weaponSecondaryArray;
	private _compatibleAmmoSecondary = compatibleMagazines [_weaponSecondary, "this"];
	private _ammoSecondary = if (_compatibleAmmoSecondary isEqualTo []) then {""} else {_compatibleAmmoSecondary select 0};

	// Get all Secondary Weapon Attachments
	private _getSecondaryAttachments = secondaryWeaponItems _unit;

	// Get Secondary Ammo Count
	private _getSecondaryAmmoCount = {_x in compatibleMagazines [secondaryWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the secondary weapon
	private _compatibleSecondaryMagazinesInventory = (magazines _unit) arrayIntersect (compatibleMagazines [secondaryWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatibleSecondaryMagazinesInventory;
	// Remove Secondary weapon
	_unit removeWeapon (secondaryWeapon _unit);

	if (_weaponSecondary != "") then {
		// Add new Secondary weapon
		_unit addWeapon _weaponSecondary;

		// Add Secondary weapon Attachments from old weapons
		// Muzzle Attachment
		if (_randomizeSecondaryMuzzle) then {
			if (random 1 <= _chanceSecondaryMuzzle || _contentSecondaryMuzzle isEqualTo "") then {
				_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 0);
			} else {
				private _weaponSecondaryAttachmentMuzzleArray = ([_contentSecondaryMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSecondaryAttachmentMuzzle = selectRandom _weaponSecondaryAttachmentMuzzleArray;
				if (_weaponSecondaryAttachmentMuzzle != "") then {
					_unit addSecondaryWeaponItem _weaponSecondaryAttachmentMuzzle;
				};
			};
		} else {
			private _oldMuzzle = _getSecondaryAttachments select 0;
			if (_oldMuzzle != "") then {
				_unit addSecondaryWeaponItem _oldMuzzle;
			};
		};
	
		// Rail Attachment
		if (_randomizeSecondaryRail) then {
			if (random 1 <= _chanceSecondaryRail || _contentSecondaryRail isEqualTo "") then {
				_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 1);
			} else {
				private _weaponSecondaryAttachmentRailArray = ([_contentSecondaryRail] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSecondaryAttachmentRail = selectRandom _weaponSecondaryAttachmentRailArray;
				if (_weaponSecondaryAttachmentRail != "") then {
					_unit addSecondaryWeaponItem _weaponSecondaryAttachmentRail;
				};
			};
		} else {
			private _oldRail = _getSecondaryAttachments select 1;
			if (_oldRail != "") then {
				_unit addSecondaryWeaponItem _oldRail;
			};
		};

		// Sight
		if (_randomizeSecondaryScope) then {
			if (random 1 <= _chanceSecondaryScope || _contentSecondaryScope isEqualTo "") then {
				_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 2);
			} else {
				private _weaponSecondaryAttachmentScopeArray = ([_contentSecondaryScope] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSecondaryAttachmentScope = selectRandom _weaponSecondaryAttachmentScopeArray;
				if (_weaponSecondaryAttachmentScope != "") then {
					_unit addSecondaryWeaponItem _weaponSecondaryAttachmentScope;
				};
			};
		} else {
			private _oldScope = _getSecondaryAttachments select 2;
			if (_oldScope != "") then {
				_unit addSecondaryWeaponItem _oldScope;
			};
		};

		// Bipod
		if (_randomizeSecondaryBipod) then {
			if (random 1 <= _chanceSecondaryBipod || _contentSecondaryBipod isEqualTo "") then {
				_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 3);
			} else {
				private _weaponSecondaryAttachmentBipodArray = ([_contentSecondaryBipod] call CBA_fnc_removeWhitespace) splitString ",";
				private _weaponSecondaryAttachmentBipod = selectRandom _weaponSecondaryAttachmentBipodArray;
				if (_weaponSecondaryAttachmentBipod != "") then {
					_unit addSecondaryWeaponItem _weaponSecondaryAttachmentBipod;
				};
			};
		} else {
			private _oldBipod = _getSecondaryAttachments select 3;
			if (_oldBipod != "") then {
				_unit addSecondaryWeaponItem _oldBipod;
			};
		};

		// Magazine 
		if (_ammoSecondary != "") then {
			_unit addSecondaryWeaponItem _ammoSecondary;

			// Add Secondary weapon Magazines 
			_unit addMagazines [_ammoSecondary, _getSecondaryAmmoCount];
		};
	};
};

if ((primaryWeapon _unit) isNotEqualTo  "") exitWith {
	_unit selectWeapon (primaryWeapon _unit);
};

if (((handgunWeapon _unit) isNotEqualTo  "") && ((primaryWeapon _unit) isEqualTo  "")) exitWith {
	_unit selectWeapon (handgunWeapon _unit);
};

if (((secondaryWeapon _unit) isNotEqualTo  "") && ((primaryWeapon _unit) isEqualTo  "") && ((handgunWeapon _unit) isEqualTo  "")) exitWith {
	_unit selectWeapon (secondaryWeapon _unit);
};
