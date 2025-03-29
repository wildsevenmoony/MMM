params ["_unit"];

[_unit, "PATH"] remoteExec ["disableAI", 0, true];
_unit setVariable ["MMM_var_AI_Stationary", true, true];
