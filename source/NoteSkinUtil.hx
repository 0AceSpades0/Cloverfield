package;

class NoteSkinUtil {
    public static function getSkinList():Array<String> {
        return CoolUtil.coolTextFile(Paths.modFolders("data/noteSkins.txt"));
    }

    public static function getNoteSkinMap():Map<String, String> {
        var map:Map<String, String> = new Map();
        var xmlPath = Paths.modFolders("data/noteSkinMappings.xml");

        if (sys.FileSystem.exists(xmlPath)) {
            var raw:String = sys.io.File.getContent(xmlPath);
            var xml:Xml = Xml.parse(raw).firstElement();

            for (skin in xml.elementsNamed("skin")) {
                var name = skin.get("name");
                var file = skin.get("file");
                if (name != null && file != null)
                    map.set(name, file);
            }
        }

        return map;
    }

     public static function getOverrideSplashIndex(skinName:String):Null<Int> {
        var xmlPath = Paths.modFolders("data/noteSkinMappings.xml");

        if (sys.FileSystem.exists(xmlPath)) {
            var raw:String = sys.io.File.getContent(xmlPath);
            var xml:Xml = Xml.parse(raw).firstElement();

            for (skin in xml.elementsNamed("skin")) {
                if (skin.get("name") == skinName) {
                    var indexStr = skin.get("overrideSplashIndex");
                    if (indexStr != null && indexStr.length > 0) {
                        return Std.parseInt(indexStr);
                    }
                }
            }
        }

        return null;
    }
    public static function getNoteSkin(skinType:String):String {
        var map = getNoteSkinMap();
        return map.exists(skinType) ? map.get(skinType) : "NOTE_assets";
    }
}
