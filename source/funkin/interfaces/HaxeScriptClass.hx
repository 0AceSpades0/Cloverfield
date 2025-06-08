package funkin.interfaces;

interface HaxeScriptClass {
    @:optional public function create():Void;
    @:optional public function createPost():Void;
    @:optional public function update(elapsed:Float):Void;
    @:optional public function updatePost(elapsed:Float):Void;

    @:optional public function getCustomFunctions():Map<String, Dynamic>;
}
