params ["_unit"];

[_unit, "PATH"] remoteExec ["disableAI", 0, true];
_unit setVariable ["mmm_var_AI_Stationary", true, true];
