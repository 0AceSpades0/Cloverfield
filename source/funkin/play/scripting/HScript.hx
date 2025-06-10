package funkin.play.scripting;

class HScript
{
	public static var parser:Parser = new Parser();
	public var interp:Interp;

	public var variables(get, never):Map<String, Dynamic>;

	public function get_variables()
	{
		return interp.variables;
	}

	public function new(isFile:Bool = false, ?code:Expr, ?extraParams:StringMap<Dynamic>)
	{
		interp = new Interp();
		set('FlxBar', flixel.ui.FlxBar);
		set('FlxG', FlxG);
		set('FlxSprite', FlxSprite);
		set('FlxCamera', FlxCamera);
		set('FlxTimer', FlxTimer);
		set('FlxTween', FlxTween);
		set('FlxEase', FlxEase);
		set('PlayState', PlayState);
		set('game', PlayState.instance);
		set('Array', Array);
		set('FlxTypedGroup', FlxTypedGroup);
		set('FlxBasic ', FlxBasic);
		set("ShaderFilter", openfl.filters.ShaderFilter);
		set("ColorMatrixFilter", openfl.filters.ColorMatrixFilter);
		set("newColorMatrixFilter", (matrix:Array<Float>)->{
			return new openfl.filters.ColorMatrixFilter(matrix);
		});
		set('FlxSpriteGroup', FlxSpriteGroup);
		set('Paths', Paths);
		set('Conductor', Conductor);
		set('ClientPrefs', ClientPrefs);
		set('GameOverSubstate', GameOverSubstate);
		set('Character', Character);
		set('Alphabet', Alphabet);
		set('CustomSubstate', CustomSubstate);
		set("OpenFlAssets", openfl.utils.Assets);
		set("WindowName", openfl.Lib.application.window.title);
		set('Map', haxe.ds.StringMap);
		set('StringMap', haxe.ds.StringMap);
		set('Save', FlxG.save.data);
		set("FlxShader", flixel.system.FlxAssets.FlxShader);
		set("FlxAssets", flixel.system.FlxAssets);
		set("Dynamic", Dynamic);
		set('Note', Note);
		set('NoteSplash', NoteSplash);
		// STRUM NOTE CLASSES
		set('StrumNote', StrumNote);
		set('Strumline', StrumNote);
		set('Strums', StrumNote);
		// STRUM NOTE CLASSES
		set("FlxColor", RealColor); // lol

		set("BGSprite", BGSprite);
		set("AttachedSprite", AttachedSprite);
		set("AttachedText", AttachedText);
		set("Alphabet", Alphabet);

		set('Sound', Sound);
		set('FileSystem', FileSystem);
		set("File", File);

		set('Cursor', Cursor);
		set('Mouse', FlxG.mouse);

		set("Std", Std);
		set("Type", Type);
		set("Math", Math);
		set("script", this);
		set("StringTools", StringTools);
		set("FlxCameraFollowStyle", {
			LOCKON: flixel.FlxCameraFollowStyle.LOCKON,
			PLATFORMER: flixel.FlxCameraFollowStyle.PLATFORMER,
			TOPDOWN: flixel.FlxCameraFollowStyle.TOPDOWN,
			TOPDOWN_TIGHT: flixel.FlxCameraFollowStyle.TOPDOWN_TIGHT,
			SCREEN_BY_SCREEN: flixel.FlxCameraFollowStyle.SCREEN_BY_SCREEN,
			NO_DEAD_ZONE: flixel.FlxCameraFollowStyle.NO_DEAD_ZONE,

		});
		set("FlxTextBorderStyle", {
			NONE: flixel.text.FlxText.FlxTextBorderStyle.NONE,
			SHADOW: flixel.text.FlxText.FlxTextBorderStyle.SHADOW,
			OUTLINE: flixel.text.FlxText.FlxTextBorderStyle.OUTLINE,
			OUTLINE_FAST: flixel.text.FlxText.FlxTextBorderStyle.OUTLINE_FAST
		});
		set("FlxTextAlign", {
			CENTER: flixel.text.FlxText.FlxTextAlign.CENTER,
			JUSTIFY: flixel.text.FlxText.FlxTextAlign.JUSTIFY,
			LEFT: flixel.text.FlxText.FlxTextAlign.LEFT,
			RIGHT: flixel.text.FlxText.FlxTextAlign.RIGHT
		});
		set("setTxtFormat", function(txt:flixel.text.FlxText, ?Font:String, Size:Int = 8, Color:FlxColor = FlxColor.WHITE, ?Alignment:flixel.text.FlxText.FlxTextAlign, ?BorderStyle:flixel.text.FlxText.FlxTextBorderStyle, BorderColor:FlxColor = FlxColor.TRANSPARENT, EmbeddedFont:Bool = true){
			txt.setFormat(Font, Size, Color, Alignment, BorderStyle, BorderColor, EmbeddedFont);
		});

		set("FlxAxes", {
			X: flixel.util.FlxAxes.X,
			Y: flixel.util.FlxAxes.Y,
			XY: flixel.util.FlxAxes.XY
		});

		set('importClass', function(libName:String, ?libPackage:String = ''){
				var str:String = '';
				if(libPackage.length > 0)
					str = libPackage + '.';

				set(libName, Type.resolveClass(str + libName));
		});
		set('addHaxeLibrary', function(libName:String, ?libPackage:String = ''){
			var str:String = '';
			if(libPackage.length > 0)
				str = libPackage + '.';
			set(libName, Type.resolveClass(str + libName));
		});
		set('import', function(libName:String, ?libPackage:String = ''){
			var str:String = '';
			if(libPackage.length > 0)
				str = libPackage + '.';
			set(libName, Type.resolveClass(str + libName));
		});
		set('Json', Json);
		set('Xml', Xml);
		#if (!flash && sys)
		set('FlxRuntimeShader', FlxRuntimeShader);
		#end
		set('ShaderFilter', openfl.filters.ShaderFilter);
		set('StringTools', StringTools);

		set('setVar', function(name:String, value:Dynamic)
		{
			PlayState.instance.variables.set(name, value);
		});
		set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if(PlayState.instance.variables.exists(name)) result = PlayState.instance.variables.get(name);
			return result;
		});
		set('removeVar', function(name:String)
		{
			if(PlayState.instance.variables.exists(name))
			{
				PlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});

		set('class', function(classArgs:Array<Dynamic>, ?extendingClass:Dynamic){
			var classTxt = classArgs;
		});

		if (isFile){
			HScript.parser.line = 1;
			HScript.parser.allowTypes = true;
			HScript.parser.allowMetadata = true;
			HScript.parser.allowJSON = true;
			if (extraParams != null)
			{
				for (i in extraParams.keys())
					set(i, extraParams.get(i));
			}
			interp.execute(code);
			if (existsFunc_("onCreate")){
				getFunc_("onCreate")();
			}
		}
	}

	public function set(variable:String, data:Dynamic){
		interp.variables.set(variable, data);
	}

	public function existsFunc_(variable:String):Bool{
		return interp.variables.exists(variable);
	}

	public function getFunc_(variable:String):Dynamic{
		return interp.variables.get(variable);
	}
	
	public function execute(codeToRun:String):Dynamic
	{
		@:privateAccess
		HScript.parser.line = 1;
		HScript.parser.allowTypes = true;
		HScript.parser.allowMetadata = true;
		HScript.parser.allowJSON = true;
		return interp.execute(HScript.parser.parseString(codeToRun));
	}
}