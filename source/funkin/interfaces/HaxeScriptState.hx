package funkin.interfaces;

interface HaxeScriptState {
    public var curStep:Int;
    public var curBeat:Int;

    public function create():Void;
    public function update(elapsed:Float):Void;
    public function stepHit():Void;
    public function beatHit():Void;
}