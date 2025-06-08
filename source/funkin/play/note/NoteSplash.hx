package funkin.play.note;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = NoteSplashUtil.getSplashAsset(ClientPrefs.noteSplashSkin);

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);

		if (texture == null) {
			texture = NoteSplashUtil.getSplashAsset(ClientPrefs.noteSplashSkin);
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;
		loadXMLSettings(texture);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('note' + note + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}

function loadXMLSettings(skin:String):Void {
	var path:String = "images/" + skin + "CONFIG.xml";
	var file:String = Paths.getTextFromFile(path); // Supports both assets and mods

	if (file == null) return; // File doesn't exist

	try {
		var xml:Xml = Xml.parse(file).firstElement();
		var node = new haxe.xml.Access(xml);

		// Offset
		if (node.hasNode.offset) {
			var offX = Std.parseFloat(node.node.offset.att.x);
			var offY = Std.parseFloat(node.node.offset.att.y);
			offset.set(offX, offY);
		}

		// Alpha
		if (node.hasNode.alpha) {
			alpha = Std.parseFloat(node.node.alpha.att.value);
		}

// Softcoded animations
if (node.hasNode.animations) {
	for (noteNode in node.node.animations.nodes.note) {
		var id:Int = Std.parseInt(noteNode.att.id);
		if (id < 0 || id > 3) continue; // Valid note IDs are 0 to 3

		var prefix:String = noteNode.att.prefix;
		var variations:Int = Std.parseInt(noteNode.att.variations);
		var frameRate:Int = Std.parseInt(noteNode.att.frameRate);

		for (i in 1...3) {
			var animName = 'note${id}-${i}';
			var frameName = '${prefix}';
			animation.addByPrefix(animName, frameName, frameRate, false);
		}
	}
}
	} catch (e:Dynamic) {
		trace('Error parsing note splash XML config: $e');
	}
}



}