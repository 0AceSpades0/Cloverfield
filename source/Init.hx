package;
import flixel.FlxState;

class Init extends flixel.FlxState 
{
    override public function create():Void
    {
        super.create();
        FlxG.switchState(new TitleState());
    }
}