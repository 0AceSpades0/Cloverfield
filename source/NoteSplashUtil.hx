package;

class NoteSplashUtil {
	public static function getSplashList():Array<String> {
		return CoolUtil.coolTextFile(Paths.modFolders("data/noteSplashSkins.txt"));
	}

	public static function getSplashMap():Map<String, String> {
		var map:Map<String, String> = new Map();
		var xmlPath = Paths.modFolders("data/noteSplashMappings.xml");

		if (sys.FileSystem.exists(xmlPath)) {
			var raw:String = sys.io.File.getContent(xmlPath);
			var xml:Xml = Xml.parse(raw).firstElement();
			for (skin in xml.elementsNamed("skin")) {
				var name = skin.get("name");
				var file = skin.get("file");
				if (name != null && file != null) map.set(name, file);
			}
		}
		return map;
	}

	public static function getSplashAsset(skinName:String):String {
		var map = getSplashMap();
		return map.exists(skinName) ? map.get(skinName) : "splashes/noteSplashes";
	}
}

