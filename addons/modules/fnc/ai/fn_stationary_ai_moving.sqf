params ["_unit"];

[_unit, "PATH"] remoteExec ["enableAI", 0, true];
_unit setVariable ["MMM_var_AI_Stationary", false, true];