#include "script_component.hpp"

/*
 * Author: Moony
 * Registers client-side MHQ respawn cleanup.
 */

if (!hasInterface) exitWith {};

addMissionEventHandler ["EntityRespawned", {
    params ["_newEntity"];

    if (_newEntity isEqualTo player) then {
        [_newEntity] spawn EFUNC(modules,mobileHQHandleRespawn);
    };
}];
