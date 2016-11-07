//<?
namespace Gmt;
class Ui
{

public	static	function deal(array specList, specArgs)
{
	if empty specList {
		return "";
	}

	int specId;
	int specCount = count(specList);
	var specName, specText, res = "";

	for specId in range(0,specCount - 1) {
		let specName = specList[specId];

		if isset specArgs[specName] {
			let specText = call_user_func_array(["\\ui\\spec", "text"], [specName, specArgs[specName]]);
		} else {
			let specText = call_user_func_array(["\\ui\\spec", "text"], [specName]);
		}

		if is_null(specText) {
			throw new \Exception(" wrong project : ". specName . ", check it ! ");
		} elseif  specText === 0 {
			throw new \Exception(" 没有相关信息:" . specName . " 未配置相关信息!");
		} elseif is_bool(specText) {
			throw  new \Exception(" 非法访问 :" . specName . " 权限不够！");
		}

		let res .= specText;
	}

	return res;
}

public	static	function paramTypesOfSpecList(array specList)
{
	var spec, paramList, pname;
	var paramTypes	= [];
	var baseParamTypes = [];
	let baseParamTypes = call_user_func(["\\svc\\param", "get_param_types"]);

	for spec in specList {
		let paramList	= call_user_func_array(["\\ui\\spec", "param_list"], [spec]);

		if !paramList {
			continue;
		}

		if paramList[0] == 1 {
			let paramTypes = array_merge(paramTypes, paramList[1]);
			continue;
		}

		for pname in paramList[1] {
			if !isset baseParamTypes[pname] {
				throw new \Exception ("未定义的 type：[".pname."], 来自于 spec:".spec. "\n");
			}
			let paramTypes[pname] = baseParamTypes[pname];
		}
		
	}

	return paramTypes;
}

public	static	function paramListOfSpecList(array specList)
{
	var spec, specParamList;
	var paramList = [];

	for spec in specList {
		let specParamList	= call_user_func_array(["\\ui\\spec", "param_list"], [spec]);
		let paramList		= array_merge(paramList, specParamList);
	}

	return paramList;
}

public	static	function validateArgsTypes(args, param)
{
	var type, typeName, arg, paramName;

	for paramName,type in param {
		if isset args[paramName] {
			let arg = args[paramName];
		} else {
			let arg = null;
		}

		if !call_user_func_array(["\\svc\\type", "validate"], [arg, type]) {
			let typeName = call_user_func_array(["\\svc\\type","friendly_name"], [type]);
			if isset type[1] {
				return sprintf("格式不正确 - %s : %s", type[1], typeName);
			} else {
				return sprintf("格式不正确 - %s ", typeName);
			}
		}
//		之后实现
//		if \adm\sql::is_secure(arg){
//			return "参数" . param_name . "应当是SQL友好的，但它的值" . arg . "不是。";
//		}
	}
	return true;
}

}
