class Cfg3DEN
{
	class EventHandlers
	{
		class mmm_modules_animationPreview
		{
			onEditableEntityAdded = QUOTE(call EFUNC(modules,refreshAnimationPreview3DEN));
			onEntityAttributeChanged = QUOTE(call EFUNC(modules,refreshAnimationPreview3DEN));
			onMissionLoad = QUOTE([] spawn {uiSleep 0.5; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 1; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 1.5; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 2; [] call EFUNC(modules,refreshAnimationPreview3DEN);});
			onMissionPreviewEnd = QUOTE([] spawn {uiSleep 0.5; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 1; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 1.5; [] call EFUNC(modules,refreshAnimationPreview3DEN); uiSleep 2; [] call EFUNC(modules,refreshAnimationPreview3DEN);});
		};
	};
};
