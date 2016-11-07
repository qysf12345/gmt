//<?
namespace Gmt;
class Zoo
{
private tagHead;
private obs	= [];
private	className;

public	function __construct(string className)
{
	let this->className = className;
	let this->tagHead	= sprintf("%s_%s_","SINGLE_ZOO_OB",className);
}

public	function registerOb(string name, object ob)
{
	if !Cached::set(this->tagHead . name, ob, 1, 600) {
		let this->obs[name] = ob;
		return true;
	}
	return true;
}

public	function releaseOb(name)
{
	return Cached::delete(this->tagHead . name);
}

public	function fetchOb(name)
{
	if isset this->obs[name] {
		return this->obs[name];
	}

	var ob;
	let ob = Cached::get(this->tagHead.name);

	if ob {
		return unserialize(ob);
	}

	var className = sprintf("\\obj\\%s",this->className);
	
	let ob = new {className}();

	if !ob->setup(name) {
		return NULL;
	}

	return ob;
}

}
