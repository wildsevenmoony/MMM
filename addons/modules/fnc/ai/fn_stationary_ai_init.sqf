params [
  ["_logic", ObjNull,[ObjNull]],
	["_ai", [], [[]]],
  ["_activated",true ,[true]]
];

_condition = _logic getVariable ["MMM_Module_AI_Stationary", "group"];

if (_condition isEqualTo "group") then {
	{
		{
			[_x] remoteexec ["MMM_fnc_stationary_ai_stationary", _x];
		} forEach units group _x;
	} forEach _ai;
} else {
	{
		[_x] remoteexec ["MMM_fnc_stationary_ai_stationary", _x];		
	} forEach _ai;
};