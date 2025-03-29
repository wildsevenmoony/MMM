params [
    ["_logic", ObjNull, [ObjNull]],
	["_objs", [], [[]]]
];

{
	[_x] call MMM_fnc_baseMedic;
} forEach _objs;