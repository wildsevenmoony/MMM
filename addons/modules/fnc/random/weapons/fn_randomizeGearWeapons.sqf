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
	"_contentSidearmBipod"
];

// Waits till other randomizations have happened
private _flags = [
    "MMM_var_randomizationBackpacksDone",
    "MMM_var_randomizationHeadgearDone",
    "MMM_var_randomizationUniformsDone",
    "MMM_var_randomizationVestsDone"
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
	#include "fn_defaultPrimary.hpp"

	if (_contentPrimary isNotEqualTo "" || _contentPrimary isNotEqualTo "[]") then {
		_weaponPrimaryArray = ([_contentPrimary] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _weaponPrimary = selectRandom _weaponPrimaryArray;
	private _ammoPrimary = (compatibleMagazines [_weaponPrimary, "this"]) select 0;

	// Get all Primary Weapon Attachments
	private _getPrimaryAttachments = primaryWeaponItems _unit;

	// Get Primary Ammo Count
	private _getPrimaryAmmoCount = {_x in compatibleMagazines [primaryWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the primary weapon
	private _compatiblePrimaryMagazinesInvewntory = (magazines _unit) arrayIntersect (compatibleMagazines [primaryWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatiblePrimaryMagazinesInvewntory;
	// Remove Primary weapon
	_unit removeWeapon (primaryWeapon _unit);

	// Add new Primary weapon
	_unit addWeapon _weaponPrimary;

	// Add Primary weapon Attachments from old weapons
	// Muzzle Attachment
	if (_randomizePrimaryMuzzle) then {
		if (random 1 < _chancePrimaryMuzzle) then {
			_unit removePrimaryWeaponItem (_getPrimaryAttachments select 0);
		} else {
			private _weaponPrimaryAttachmentMuzzleArray = ([_contentPrimaryMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponPrimaryAttachmentMuzzle = selectRandom _weaponPrimaryAttachmentMuzzleArray;
			_unit addPrimaryWeaponItem _weaponPrimaryAttachmentMuzzle;
		};
	} else {
		_unit addPrimaryWeaponItem (_getPrimaryAttachments select 0);
	};
	
	// Rail Attachment
	if (_randomizePrimaryRail) then {
		if (random 1 < _chancePrimaryRail) then {
			_unit removePrimaryWeaponItem (_getPrimaryAttachments select 1);
		} else {
			private _weaponPrimaryAttachmentRailArray = ([_contentPrimaryRail] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponPrimaryAttachmentRail = selectRandom _weaponPrimaryAttachmentRailArray;
			_unit addPrimaryWeaponItem _weaponPrimaryAttachmentRail;
		};
	} else {
		_unit addPrimaryWeaponItem (_getPrimaryAttachments select 1);
	};

	// Sight
	if (_randomizePrimaryScope) then {
		if (random 1 < _chancePrimaryScope) then {
			_unit removePrimaryWeaponItem (_getPrimaryAttachments select 2);
		} else {
			private _weaponPrimaryAttachmentScopeArray = ([_contentPrimaryScope] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponPrimaryAttachmentScope = selectRandom _weaponPrimaryAttachmentScopeArray;
			_unit addPrimaryWeaponItem _weaponPrimaryAttachmentScope;
		};
	} else {
		_unit addPrimaryWeaponItem (_getPrimaryAttachments select 2);
	};

	// Bipod
	if (_randomizePrimaryBipod) then {
		if (random 1 < _chancePrimaryBipod) then {
			_unit removePrimaryWeaponItem (_getPrimaryAttachments select 3);
		} else {
			private _weaponPrimaryAttachmentBipodArray = ([_contentPrimaryBipod] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponPrimaryAttachmentBipod = selectRandom _weaponPrimaryAttachmentBipodArray;
			_unit addPrimaryWeaponItem _weaponPrimaryAttachmentBipod;
		};
	} else {
		_unit addPrimaryWeaponItem (_getPrimaryAttachments select 3);
	};

	// Magazine 
	_unit addPrimaryWeaponItem _ammoPrimary;

	// Add Primary weapon Magazines 
	_unit addMagazines [_ammoPrimary, _getPrimaryAmmoCount];
};

// Randomizes Sidearm Weapon if enabled
if (_randomizeSidearm && ((_forceSidearm) || (!_forceSidearm && (handgunWeapon _unit) != ""))) then {
	#include "fn_defaultSidearm.hpp"

	if (_contentSidearm isNotEqualTo "" || _contentSidearm isNotEqualTo "[]") then {
		private _weaponSidearmArray = ([_contentSidearm] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _weaponSidearm = selectRandom _weaponSidearmArray;
	private _ammoSidearm = (compatibleMagazines [_weaponSidearm, "this"]) select 0;

	// Get all Sidearm Weapon Attachments
	private _getSidearmAttachments = handgunItems _unit;

	// Get Sidearm Ammo Count
	private _getSidearmAmmoCount = {_x in compatibleMagazines [handgunWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the primary weapon
	private _compatibleSidearmMagazinesInvewntory = (magazines _unit) arrayIntersect (compatibleMagazines [handgunWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatibleSidearmMagazinesInvewntory;
	// Remove Sidearm weapon
	_unit removeWeapon (handgunWeapon _unit);

	// Add new Sidearm weapon
	_unit addWeapon _weaponSidearm;

	// Add Sidearm weapon Attachments from old weapons
	// Muzzle Attachment
	if (_randomizeSidearmMuzzle) then {
		if (random 1 < _chanceSidearmMuzzle) then {
			_unit removeHandgunItem (_getSidearmAttachments select 0);
		} else {
			private _weaponSidearmAttachmentMuzzleArray = ([_contentSidearmMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSidearmAttachmentMuzzle = selectRandom _weaponSidearmAttachmentMuzzleArray;
			_unit addHandgunItem _weaponSidearmAttachmentMuzzle;
		};
	} else {
		_unit addHandgunItem (_getSidearmAttachments select 0);
	};
	
	// Rail Attachment
	if (_randomizeSidearmRail) then {
		if (random 1 < _chanceSidearmRail) then {
			_unit removeHandgunItem (_getSidearmAttachments select 1);
		} else {
			private _weaponSidearmAttachmentRailArray = ([_contentSidearmRail] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSidearmAttachmentRail = selectRandom _weaponSidearmAttachmentRailArray;
			_unit addHandgunItem _weaponSidearmAttachmentRail;
		};
	} else {
		_unit addHandgunItem (_getSidearmAttachments select 1);
	};

	// Sight
	if (_randomizeSidearmScope) then {
		if (random 1 < _chanceSidearmScope) then {
			_unit removeHandgunItem (_getSidearmAttachments select 2);
		} else {
			private _weaponSidearmAttachmentScopeArray = ([_contentSidearmScope] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSidearmAttachmentScope = selectRandom _weaponSidearmAttachmentScopeArray;
			_unit addHandgunItem _weaponSidearmAttachmentScope;
		};
	} else {
		_unit addHandgunItem (_getSidearmAttachments select 2);
	};

	// Bipod
	if (_randomizeSidearmBipod) then {
		if (random 1 < _chanceSidearmBipod) then {
			_unit removeHandgunItem (_getSidearmAttachments select 3);
		} else {
			private _weaponSidearmAttachmentBipodArray = ([_contentSidearmBipod] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSidearmAttachmentBipod = selectRandom _weaponSidearmAttachmentBipodArray;
			_unit addHandgunItem _weaponSidearmAttachmentBipod;
		};
	} else {
		_unit addHandgunItem (_getSidearmAttachments select 3);
	};

	// Magazine 
	_unit addHandgunItem _ammoSidearm;

	// Add Sidearm weapon Magazines 
	_unit addMagazines [_ammoSidearm, _getSidearmAmmoCount];
};

// Randomizes Secondary Weapon if enabled
if (_randomizeSecondary && ((_forceSecondary) || (!_forceSecondary && (secondaryWeapon _unit) != ""))) then {
	#include "fn_defaultSecondary.hpp"

	if (_contentSecondary isNotEqualTo "" || _contentSecondary isNotEqualTo "[]") then {
		private _weaponSecondaryArray = ([_contentSecondary] call CBA_fnc_removeWhitespace) splitString ",";
	};
	private _weaponSecondary = selectRandom _weaponSecondaryArray;
	private _ammoSecondary = (compatibleMagazines [_weaponSecondary, "this"]) select 0;

	// Get all Secondary Weapon Attachments
	private _getSecondaryAttachments = secondaryWeaponItems _unit;

	// Get Secondary Ammo Count
	private _getSecondaryAmmoCount = {_x in compatibleMagazines [secondaryWeapon _unit, "this"]} count magazines _unit;
	

	//Remove all magazines (not underbarrel) from the unit that fit into the secondary weapon
	private _compatibleSecondaryMagazinesInvewntory = (magazines _unit) arrayIntersect (compatibleMagazines [secondaryWeapon _unit, "this"]);
	{
		_unit removeMagazines _x;
	} forEach _compatibleSecondaryMagazinesInvewntory;
	// Remove Secondary weapon
	_unit removeWeapon (secondaryWeapon _unit);

	// Add new Secondary weapon
	_unit addWeapon _weaponSecondary;

	// Add Secondary weapon Attachments from old weapons
	// Muzzle Attachment
	if (_randomizeSecondaryMuzzle) then {
		if (random 1 < _chanceSecondaryMuzzle) then {
			_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 0);
		} else {
			private _weaponSecondaryAttachmentMuzzleArray = ([_contentSecondaryMuzzle] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSecondaryAttachmentMuzzle = selectRandom _weaponSecondaryAttachmentMuzzleArray;
			_unit addSecondaryWeaponItem _weaponSecondaryAttachmentMuzzle;
		};
	} else {
		_unit addSecondaryWeaponItem (_getSecondaryAttachments select 0);
	};
	
	// Rail Attachment
	if (_randomizeSecondaryRail) then {
		if (random 1 < _chanceSecondaryRail) then {
			_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 1);
		} else {
			private _weaponSecondaryAttachmentRailArray = ([_contentSecondaryRail] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSecondaryAttachmentRail = selectRandom _weaponSecondaryAttachmentRailArray;
			_unit addSecondaryWeaponItem _weaponSecondaryAttachmentRail;
		};
	} else {
		_unit addSecondaryWeaponItem (_getSecondaryAttachments select 1);
	};

	// Sight
	if (_randomizeSecondaryScope) then {
		if (random 1 < _chanceSecondaryScope) then {
			_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 2);
		} else {
			private _weaponSecondaryAttachmentScopeArray = ([_contentSecondaryScope] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSecondaryAttachmentScope = selectRandom _weaponSecondaryAttachmentScopeArray;
			_unit addSecondaryWeaponItem _weaponSecondaryAttachmentScope;
		};
	} else {
		_unit addSecondaryWeaponItem (_getSecondaryAttachments select 2);
	};

	// Bipod
	if (_randomizeSecondaryBipod) then {
		if (random 1 < _chanceSecondaryBipod) then {
			_unit removeSecondaryWeaponItem (_getSecondaryAttachments select 3);
		} else {
			private _weaponSecondaryAttachmentBipodArray = ([_contentSecondaryBipod] call CBA_fnc_removeWhitespace) splitString ",";
			private _weaponSecondaryAttachmentBipod = selectRandom _weaponSecondaryAttachmentBipodArray;
			_unit addSecondaryWeaponItem _weaponSecondaryAttachmentBipod;
		};
	} else {
		_unit addSecondaryWeaponItem (_getSecondaryAttachments select 3);
	};

	// Magazine 
	_unit addSecondaryWeaponItem _ammoSecondary;

	// Add Secondary weapon Magazines 
	_unit addMagazines [_ammoSecondary, _getSecondaryAmmoCount];
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