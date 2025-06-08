package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class NoteSkinSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Notes';
		rpcTitle = 'Notes Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Note Skin:',
			"note skin",
			'noteSkinType',
			'string',
			'Default',
			NoteSkinUtil.getSkinList());
		addOption(option);

		var option:Option = new Option('Note Splash Skin:',
			"note splash skin",
			'noteSplashSkin',
			'string',
			'Default',
			NoteSplashUtil.getSplashList());
		addOption(option);

		super();
	}
}
