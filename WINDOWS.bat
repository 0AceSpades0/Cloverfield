@ECHO OFF
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib run lime setup flixel
haxelib run lime setup
haxelib install flixel-tools
haxelib run flixel-tools setup
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install hscript
haxelib install newgrounds
haxelib git polymod https://github.com/larsiusprime/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
haxelib install hxCodec
haxelib install Brewscript
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec.git
haxelib git flxanimate https://github.com/ShadowMario/flxanimate dev
haxelib set flixel-addons 3.0.2
haxelib set flixel-demos 2.9.0
haxelib set flixel-templates 2.6.6
haxelib set flixel-tools 1.5.1
haxelib set flixel-ui 2.5.0
haxelib set flixel 5.2.1
haxelib set flxanimate 3.0.4
haxelib set hscript 2.5.0
haxelib set lime-samples 7.0.0
haxelib set lime 8.0.1
haxelib set openfl 9.2.1
haxelib remove hxCodec
haxelib install hxCodec 2.5.1
haxelib remove flixel-addons
haxelib install flixel-addons 2.11.0
haxelib remove flixel-ui
haxelib install flixel-ui 2.4.0
haxelib remove hxcpp
haxelib install hxcpp 4.2.1
haxelib install munit
haxelib git hscript-plus https://github.com/DleanJeans/hscript-plus/
haxelib git hscript-class https://github.com/ianharrigan/hscript-ex
PAUSE