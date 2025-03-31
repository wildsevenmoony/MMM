params [
	["_logic", objNull,[objNull]],
	["_ai", [], [[]]],
	["_activated",true ,[true]]
];

_condition = _logic getVariable ["MMM_MODULES_Module_AI_Stationary", 0];

switch (_condition) do {
	case 0: {
		{
			{
				[_x, "PATH"] remoteExec ["disableAI", 0, true];
				_x setVariable ["mmm_var_AI_Stationary", true, true];
			} forEach units group _x;
		} forEach _ai;
	};
	case 1: {
		{
				[_x, "PATH"] remoteExec ["disableAI", 0, true];
				_x setVariable ["mmm_var_AI_Stationary", true, true];		
		} forEach _ai;
	};
};