package funkin.play.results;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import funkin.gameObjects.Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

class Results extends MusicBeatState
{
    var bg:FlxSprite;
    public var score:Int;
    public var miss:Int;
    public var percent:Float;
    public var rank:String = "good";
    var resultChar:ResultsChar;
    override function create()
    {
        resultChar = new ResultsChar(rank, 200, 100); // Pass "PERFECT" or other rank strings
        resultChar.animation.play("intro");
        resultChar.animation.finishCallback = function(name:String){
            if (name == "intro") resultChar.animation.play("idle");
        };
        add(resultChar);
    }
    override function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER){
            MusicBeatState.switchState(new FreeplayState());
        }
    }
}

class ResultsChar extends FlxSprite
{
    var perfect:Bool = false;
    var introStage:Int = 1;

    public function new(rank:String, x:Int, y:Int)
    {
        super(x, y);

        perfect = (rank.toLowerCase() == "perfect");

        if (perfect)
        {
            loadPerfectIntro();
        }
        else
        {
            // Load from single spritesheet
            frames = Paths.getSparrowAtlas('results/bf/bf_' + rank);
            animation.addByPrefix("intro", "intro", 24, false);
            animation.addByPrefix("idle", "idle", 24, true);

            animation.play("intro");
            animation.finishCallback = function(name:String)
            {
                if (name == "intro") animation.play("idle");
            };
        }
    }

    function loadPerfectIntro()
    {
        // Load first intro stage
        frames = Paths.getSparrowAtlas('results/bf/perfect/intro_1');
        animation.addByPrefix("intro_1", "intro_1", 24, false);
        animation.play("intro_1");

        animation.finishCallback = function(name:String)
        {
            handlePerfectTransition();
        };
    }

    function handlePerfectTransition()
    {
        introStage++;

        if (introStage <= 4)
        {
            var nextSheet = 'results/bf/perfect/intro_' + introStage;
            frames = Paths.getSparrowAtlas(nextSheet);
            var animName = 'intro_' + introStage;
            animation.addByPrefix(animName, animName, 24, false);
            animation.play(animName);
            animation.finishCallback = function(n:String)
            {
                handlePerfectTransition();
            };
        }
        else
        {
            // After final intro stage, load idle
            frames = Paths.getSparrowAtlas('results/bf/perfect/idle');
            animation.addByPrefix("idle", "idle", 24, true);
            animation.play("idle");
        }
    }
}
