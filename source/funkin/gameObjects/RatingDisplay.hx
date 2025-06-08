package funkin.gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxState;
import flixel.FlxBasic;
import flixel.FlxCamera;
import openfl.utils.Assets;

class RatingDisplay extends FlxSprite
{
	public var currentRating:String = "?";
	public var ratingValue:Float = 0.0;

	public function new(x:Float = 992.1, y:Float = 535.2, scale:Float = 1)
	{
		super(x, y);
		frames = Paths.getSparrowAtlas("ratings"); // your "ratings.png" and "ratings.xml"

		this.scale.x = scale;
		this.scale.y = scale;

		// Add rating animations
		animation.addByPrefix('PLUS', 'PLUS', 24, false);
		animation.addByPrefix('S', 'S', 24, false);
		animation.addByPrefix('A', 'A', 24, false);
		animation.addByPrefix('B', 'B', 24, false);
		animation.addByPrefix('C', 'C', 24, false);
		animation.addByPrefix('D', 'D', 24, false);
		animation.addByPrefix('E', 'E', 24, false);
		animation.addByPrefix('F', 'F', 24, false);
		animation.addByPrefix('?', '?', 24, false);

        antialiasing = ClientPrefs.globalAntialiasing;

		setGraphicSize(Std.int(width * 0.8), Std.int(height * 0.8));
		updateHitbox();
		scrollFactor.set(0, 0);
		camera = FlxG.cameras.list[1]; // HUD camera

		visible = ClientPrefs.ratingDisplayEnabled;

		playRating('?');
	}

	public function updateRating(value:Float)
	{
		ratingValue = value;

		if (ratingValue >= 1)
			currentRating = 'PLUS';
		else if (ratingValue >= 0.98)
			currentRating = 'S';
		else if (ratingValue >= 0.90)
			currentRating = 'A';
		else if (ratingValue >= 0.80)
			currentRating = 'B';
		else if (ratingValue >= 0.70)
			currentRating = 'C';
		else if (ratingValue >= 0.50)
			currentRating = 'D';
		else if (ratingValue >= 0.21)
			currentRating = 'E';
		else
			currentRating = 'F';
	}

	public function beatHit(curBeat:Int, ratingName:String)
	{
		if (curBeat % 2 == 0 && ratingName != "?")
			playRating(currentRating);
	}

	public function playRating(label:String)
	{
		animation.play(label, true);
	}
}
