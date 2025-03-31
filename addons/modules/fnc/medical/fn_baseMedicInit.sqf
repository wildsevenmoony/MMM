params [
    ["_logic", objNull, [objNull]],
	["_objs", [], [[]]]
];

{
	[_x] call mmm_modules_fnc_baseMedic;
} forEach _objs;