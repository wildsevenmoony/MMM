class Cfg3DEN
{
	class EventHandlers
	{
		class mmm_modules_animationPreview
		{
			onEditableEntityAdded = "call mmm_modules_fnc_refreshAnimationPreview3DEN;";
			onEntityAttributeChanged = "call mmm_modules_fnc_refreshAnimationPreview3DEN;";
			onMissionLoad = "[] spawn {uiSleep 0.5; [] call mmm_modules_fnc_refreshAnimationPreview3DEN; uiSleep 1; [] call mmm_modules_fnc_refreshAnimationPreview3DEN; uiSleep 1.5; [] call mmm_modules_fnc_refreshAnimationPreview3DEN; uiSleep 2; [] call mmm_modules_fnc_refreshAnimationPreview3DEN;};";
		};
	};
};
