//<?
namespace Gmt;
class Common
{
private	static	baseDir;


public	static	function init() -> void
{
	let self::baseDir = getCwd();
	spl_autoload_register([__CLASS__,"load"]);
}

public	static	function load(string name) -> void
{
	self::loadClass(name);
}


public	static	function loadClass(string classic) -> void
{
	string file;
	let file = strtolower(str_replace("\\", "/", classic));
	require(self::baseDir."/lib/" . file . ".php");
	self::callOther(classic, "setup");
}

public	static	function other()
{
}

public  static  function callOther(string classic, string func) -> void
{
	var r, func;

	let r = new \ReflectionClass(classic);

	if !r->hasMethod(func) {
		return;
	}

	let func = r->getMethod(func);

	if !func->isStatic() {
		return;
	}

	func->invokeargs(null, []);
}


}
