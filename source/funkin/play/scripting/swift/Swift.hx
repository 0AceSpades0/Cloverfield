package funkin.play.scripting.swift;

import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import haxe.ds.StringMap;

class Swift
{
	public var filePath:String;
	public var variables:Map<String, Dynamic> = new Map();
	public var exposure:StringMap<Dynamic> = new StringMap();
	public var functions:Map<String, { args:Array<String>, body:Array<String> }> = new Map();

	public function new(filePath:String, ?extraParams:StringMap<Dynamic>)
	{
		this.filePath = filePath;

		if (extraParams != null)
		{
			for (key in extraParams.keys())
			{
				exposure.set(key, extraParams.get(key));
			}
		}

		exposure.set("print", function(args:Dynamic) {
			trace(args);
		});

		parseScript(filePath);
	}

	function runLineWithScope(line:String, local:Map<String, Dynamic>):Void
	{
var regex = ~/^var\s+(\w+):\s*(\w+)\s*=\s*(.+);?$/;
if (regex.match(line))
{
	var varName = regex.matched(1);
	var type = regex.matched(2);
	var valueRaw = StringTools.trim(regex.matched(3));
	var value:Dynamic = null;

	switch (type)
	{
		case "String":
			if (valueRaw.startsWith('"') && valueRaw.endsWith('"'))
				value = valueRaw.substr(1, valueRaw.length - 2);
		case "Int":
			value = Std.parseInt(valueRaw);
		case "Float":
			value = Std.parseFloat(valueRaw);
		case "Bool":
			value = (valueRaw == "true");
		default:
			trace('Swift: Unknown type "$type"');
	}

	local.set(varName, value);
	return;
}

		else if (line.contains('='))
		{
			var parts = line.split('=');
			if (parts.length == 2)
			{
				var varName = StringTools.trim(parts[0]);
				var valueRaw = StringTools.trim(parts[1]);

				var value:Dynamic = castValueWithScope(valueRaw, local);
				local.set(varName, value);
			}
		}
		else if (line.contains('(') && line.endsWith(')'))
		{
			callFunction(line, local);
		}
	}

	function castValueWithScope(value:String, local:Map<String, Dynamic>):Dynamic
	{
		if (local.exists(value)) return local.get(value);
		return castValue(value);
	}

	function callFunction(line:String, ?local:Map<String, Dynamic>):Void
	{
		var name = line.substr(0, line.indexOf('(')).trim();
		var inside = line.substring(line.indexOf('(') + 1, line.lastIndexOf(')')).trim();

		var args:Array<Dynamic> = [];
		if (inside != '')
		{
			var rawArgs = inside.split(',');
			for (arg in rawArgs)
			{
				args.push(castValueWithScope(StringTools.trim(arg), local));
			}
		}

		if (functions.exists(name))
		{
			getFunc_(name)(args);
			return;
		}

		if (exposure.exists(name))
		{
			var func = exposure.get(name);
			if (Reflect.isFunction(func))
			{
				Reflect.callMethod(func, func, args);
				return;
			}
		}

		trace('Swift: Function "$name" not found');
	}

	function parseScript(path:String):Void
	{
		if (!FileSystem.exists(path)) {
			trace('Swift: Script file not found: $path');
			return;
		}

		var lines:Array<String> = File.getContent(path).split('\n');
		var currentFunc:String = null;
		var funcArgs:Array<String> = [];
		var funcBody:Array<String> = [];
		var insideFunction:Bool = false;
		var braceDepth:Int = 0;

		for (line in lines)
		{
			line = StringTools.trim(line);
			if (line == '' || line.startsWith('//')) continue;

			if (!insideFunction && line.startsWith("func "))
			{
				var header = line.substr("func ".length);
				var nameEnd = header.indexOf('(');
				var name = header.substr(0, nameEnd).trim();
				var argStr = header.substring(nameEnd + 1, header.indexOf(')')).trim();
				var args = argStr == "" ? [] : argStr.split(',').map(StringTools.trim);

				currentFunc = name;
				funcArgs = args;
				funcBody = [];
				insideFunction = true;
				braceDepth = 0;

				if (line.contains("{")) braceDepth++;
				continue;
			}

			if (insideFunction)
			{
				if (line.contains("{")) braceDepth++;
				if (line.contains("}")) braceDepth--;

				if (braceDepth > 0 && line != "{")
					funcBody.push(line);

				if (braceDepth == 0)
				{
					functions.set(currentFunc, { args: funcArgs, body: funcBody });
					currentFunc = null;
					funcArgs = [];
					funcBody = [];
					insideFunction = false;
				}
			}
			else
			{
				var regex = ~/^var\s+(\w+):\s*(\w+)\s*=\s*(.+);?$/;
if (regex.match(line))
{
	var varName = regex.matched(1);
	var type = regex.matched(2);
	var valueRaw = StringTools.trim(regex.matched(3));
	var value:Dynamic = null;

	switch (type)
	{
		case "String":
			if (valueRaw.startsWith('"') && valueRaw.endsWith('"'))
				value = valueRaw.substr(1, valueRaw.length - 2);
		case "Int":
			value = Std.parseInt(valueRaw);
		case "Float":
			value = Std.parseFloat(valueRaw);
		case "Bool":
			value = (valueRaw == "true");
		default:
			trace('Swift: Unknown type "$type"');
	}

	variables.set(varName, value);
	trace('Swift: Declared $type $varName = $value');
	continue;
}

				else
				{
					runLine(line);
				}
			}
		}

		if (existsFunc_("onCreate")) {
			getFunc_("onCreate")();
		}
	}

	public function existsFunc_(name:String):Bool
	{
		return functions.exists(name);
	}

	public function getFunc_(name:String):Dynamic
	{
		if (!functions.exists(name)) return null;
		var f = functions.get(name);

		return function(?args:Array<Dynamic>):Void {
			if (args == null) args = [];
			var localVars = new Map<String, Dynamic>();
			for (i in 0...f.args.length) {
				localVars.set(f.args[i], i < args.length ? args[i] : null);
			}

			for (line in f.body)
			{
				runLineWithScope(line, localVars);
			}
		};
	}

	function runLine(line:String):Void
	{
		if (line.contains('(') && line.endsWith(')'))
		{
			callFunction(line);
		}
		else if (line.contains('='))
		{
			var parts = line.split('=');
			if (parts.length == 2)
			{
				var varName = StringTools.trim(parts[0]);
				var valueRaw = StringTools.trim(parts[1]);

				var value:Dynamic = castValue(valueRaw);
				variables.set(varName, value);

				trace('Swift: Set $varName = $value');
			}
		}
		else
		{
			trace('Swift: Unknown command -> $line');
		}
	}

	function castValue(value:String):Dynamic
	{
		if (value.startsWith('"') && value.endsWith('"'))
			return value.substr(1, value.length - 2);
		else if (value == "true" || value == "false")
			return (value == "true");
		else if (~/^-?[0-9]+$/.match(value))
			return Std.parseInt(value);
		else if (~/^-?[0-9]*\.[0-9]+$/.match(value))
			return Std.parseFloat(value);
		else if (variables.exists(value))
			return variables.get(value);
        else if (value.startsWith("new "))
{
	var type = value.substr(4).split("(")[0].trim();
}

		else if (exposure.exists(value))
		{
			var v = exposure.get(value);
			if (Reflect.isFunction(v))
				return Reflect.callMethod(v, v, []);
			return v;
		}
		return value;
	}

	public function getVar(name:String):Dynamic
	{
		return variables.exists(name) ? variables.get(name) : null;
	}

	public function setExposure(key:String, value:Dynamic):Void
	{
		exposure.set(key, value);
	}
}
