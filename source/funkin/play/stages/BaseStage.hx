package funkin.play.stages;

class BaseStage extends FlxBasic
{
    public var game:PlayState;
    public var boyfriend:Character;
    public var gf:Character;
    public var dad:Character;
    function add(object:FlxBasic) return FlxG.state.add(object);
    public function new(){}
}