package funkin.meta.data.dependency;
import flixel.util.FlxColor;

class RealColor {
	public static var BLACK:Int = FlxColor.BLACK;
	public static var BLUE:Int = FlxColor.BLUE;
	public static var CYAN:Int = FlxColor.CYAN;
	public static var GRAY:Int = FlxColor.GRAY;
	public static var GREEN:Int = FlxColor.GREEN;
	public static var LIME:Int = FlxColor.LIME;
	public static var MAGENTA:Int = FlxColor.MAGENTA;
	public static var ORANGE:Int = FlxColor.ORANGE;
	public static var PINK:Int = FlxColor.PINK;
	public static var PURPLE:Int = FlxColor.PURPLE;
	public static var RED:Int = FlxColor.RED;
	public static var TRANSPARENT:Int = FlxColor.TRANSPARENT;
	public static var WHITE:Int = FlxColor.WHITE;
	public static var YELLOW:Int = FlxColor.YELLOW;

	public static function fromCMYK(c:Float,m:Float,y:Float,b:Float,a:Float = 1):Int return cast FlxColor.fromCMYK(c,m,y,b,a);
	public static function fromHSB(h:Float,s:Float,b:Float,a:Float = 1):Int return cast FlxColor.fromHSB(h,s,b,a);
	public static function fromInt(num:Int):Int return cast FlxColor.fromInt(num);
	public static function fromRGBFloat(r:Float,g:Float,b:Float,a:Float = 1):Int return cast FlxColor.fromRGBFloat(r,g,b,a);
	public static function fromRGB(r:Int,g:Int,b:Int,a:Int = 255):Int return cast FlxColor.fromRGB(r,g,b,a);
	public static function getHSBColorWheel(a:Int = 255):Array<Int> return cast FlxColor.getHSBColorWheel(a);
	public static function gradient(color1:FlxColor, color2:FlxColor, steps:Int, ?ease:Float->Float):Array<Int> return cast FlxColor.gradient(color1,color2,steps,ease);
	public static function interpolate(color1:FlxColor, color2:FlxColor, factor:Float = 0.5):Int return cast FlxColor.interpolate(color1,color2,factor);
	public static function fromString(string:String):Int return cast FlxColor.fromString(string);
}