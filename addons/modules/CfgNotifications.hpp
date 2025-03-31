class CfgNotifications
{
	class mmm_notification_hatesarma
	{
		title = "Zeus hates Arma"; // Tile displayed as text on black background. Filled by arguments.
		description = "Anything that happens atm is because Arma and/or the AI does not behave!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\icon_sigh_white.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};

	class mmm_notification_zeushatesplayer
	{
		title = "Zeus hates Playerbase"; // Tile displayed as text on black background. Filled by arguments.
		description = "Fuck you guys!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\fuckyou.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};

	class mmm_notification_warcrimes
	{
		title = "Congratulations!"; // Tile displayed as text on black background. Filled by arguments.
		description = "You just committed a War Crime!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\icon_cake_white.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};

	class mmm_notification_healed
	{
		title = "You have been healed"; // Tile displayed as text on black background. Filled by arguments.
		description = "It's just a flesh wound!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\icon_medical_white.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};

	class mmm_notification_sombodyhealed
	{
		title = "You healed your Team Mates"; // Tile displayed as text on black background. Filled by arguments.
		description = "These c*nts should be fine now....and you too!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\icon_medical_white.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};

	class mmm_notification_healedbysomeone
	{
		title = "Someone healed you"; // Tile displayed as text on black background. Filled by arguments.
		description = "You feel like new!"; // Brief description displayed as structured text. Colored by "color", filled by arguments
		iconPicture = "z\mmm\addons\modules\img\icon_medical_white.paa";
		color[] = {1,1,1,1};
		duration = 5; // How many seconds will the notification be displayed
		priority = 7; // Priority; higher number = more important; tasks in queue are selected by priority
	};
};
