//<?
namespace Gmt;
class Cmd
{
private cmds;
private cmdData{get};

public	function __construct( var data )
{
	if !is_array(data) {
		throw new \Exception("cmd init err");
	}

	var v,cmds = [];

	for v in data {
		let cmds[v["cmdId"]] = v["path"];
	}

	ksort(cmds);
	let this->cmds = cmds;

	let this->cmdData = data;
}

public	function getCmdName(var cmdId)
{
	if isset this->cmds[cmdId] {
		return this->cmds[cmdId];
	}

	return false;
}

//@生成父子数组 parentId, childId
public	function generateTree()
{
	int i = 0;
	var k,v;
	var items = [];

	for v in this->cmdData {
		let items[v["cmdId"]] = v;
	}
	
	for k,v in items {
		if !isset items[v["parentId"]]["child"] {
			let items[v["parentId"]]["child"] = [];
		} 

		if v["parentId"] != 0 {
			unset(items[k]);
		}

		let items[v["parentId"]]["child"][i] = v;
		let i++;
	}
	
	if isset items[0] {
		unset(items[0]);
	}

	return items;
}

}
