/*
 * Author: Moony
 * Checks whether an object-style MHQ is currently moving.
 *
 * Arguments:
 * 0: MHQ object <OBJECT>
 *
 * Return Value:
 * MHQ is moving <BOOL>
 *
 * Public: No
 */

#include "\z\mmm\addons\modules\script_component.hpp"

params [["_mhq", objNull, [objNull]]];

if (isNull _mhq || {_mhq isKindOf "CAManBase"}) exitWith {false};

(speed _mhq) > 1 || {(vectorMagnitude velocity _mhq) > 0.5}
