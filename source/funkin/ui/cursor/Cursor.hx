package funkin.ui.cursor;

import flixel.FlxG; // import the cursor class

class Cursor
{
    public function new()
    {
        createDefault();
    }

    public static function createDefault()
    {
        if (ClientPrefs.systemCursor){
            useEpicSystemCursor();
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.mouse.visible = true;
            FlxG.mouse.unload();
            FlxG.log.add("Sexy mouse cursor " + "content/images/cursor/cursor-default.png");
            FlxG.mouse.load("content/images/cursor/cursor-default.png");
        }
    }

    public static function createPointer()
    {
        if (ClientPrefs.systemCursor){
            useEpicSystemCursor();
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.mouse.visible = true;
            FlxG.mouse.unload();
            FlxG.log.add("Sexy mouse cursor " + "content/images/cursor/cursor-pointer.png");
            FlxG.mouse.load("content/images/cursor/cursor-pointer.png");
        }
    }

    public static function createCell()
    {
        if (ClientPrefs.systemCursor){
            useEpicSystemCursor();
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.mouse.visible = true;
            FlxG.mouse.unload();
            FlxG.log.add("Sexy mouse cursor " + "content/images/cursor/cursor-cell.png");
            FlxG.mouse.load("content/images/cursor/cursor-cell.png");
        }
    }

    public static function createGrabbing()
    {
        if (ClientPrefs.systemCursor){
            useEpicSystemCursor();
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.mouse.visible = true;
            FlxG.mouse.unload();
            FlxG.log.add("Sexy mouse cursor " + "content/images/cursor/cursor-grabbing.png");
            FlxG.mouse.load("content/images/cursor/cursor-grabbing.png");
        }
    }

    public static function unloadCursor()
    {
        FlxG.mouse.visible = false;
        FlxG.mouse.unload();   
        FlxG.mouse.useSystemCursor = false;
    }
    public static function useEpicSystemCursor()
    {
        FlxG.mouse.visible = true;
        FlxG.mouse.unload();   
        FlxG.mouse.useSystemCursor = true;
    }
}