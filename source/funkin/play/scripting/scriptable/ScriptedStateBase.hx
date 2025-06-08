package funkin.play.scripting.scriptable;

import funkin.interfaces.HaxeScriptState;
import hscript.Interp;
import sys.io.File;
import hscript.Parser;
import haxe.io.Path;

class ScriptedStateBase extends MusicBeatState implements HaxeScriptState {
	public var curStep:Int = 0;
	public var curBeat:Int = 0;

	var interp:Interp;
	var scriptObject:Dynamic;

	public function new() {
		super();
		loadScript();
	}

	public function create():Void {
		if (hasFunction("create")) Reflect.callMethod(scriptObject, Reflect.field(scriptObject, "create"), []);
	}

	public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (hasFunction("update")) Reflect.callMethod(scriptObject, Reflect.field(scriptObject, "update"), [elapsed]);
	}

	public function stepHit():Void {
		super.stepHit();
		if (hasFunction("stepHit")) Reflect.callMethod(scriptObject, Reflect.field(scriptObject, "stepHit"), []);
	}

	public function beatHit():Void {
		super.beatHit();
		if (hasFunction("beatHit")) Reflect.callMethod(scriptObject, Reflect.field(scriptObject, "beatHit"), []);
	}

	function loadScript():Void {
		var className = Type.getClassName(Type.getClass(this)).split(".").pop(); // gets PlayState, CustomModState, etc.
		var scriptPath = Paths.modFolders("states/" + className + ".hxs");

		if (!sys.FileSystem.exists(scriptPath)) return;

		try {
			var parser = new Parser();
			parser.allowTypes = true;
			var program = parser.parseString(File.getContent(scriptPath));
			interp = new Interp();
			
			// Expose self and vars
			interp.variables.set("this", this);
			interp.variables.set("curStep", curStep);
			interp.variables.set("curBeat", curBeat);

			scriptObject = interp.execute(program);
		} catch (e) {
			trace("Failed to load script for " + className + ": " + e);
		}
	}

	inline function hasFunction(name:String):Bool {
		return scriptObject != null && Reflect.hasField(scriptObject, name);
	}
}
