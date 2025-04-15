params ["_unit"];

[_unit, "PATH"] remoteExec ["enableAI", 0, true];
_unit setVariable ["mmm_var_AI_Stationary", false, true];