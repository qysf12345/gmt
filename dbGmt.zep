//<?
namespace Gmt;
class DbGmt
{

public	static	function run(string procName, args)
{
	string mode	= "\\mode\\db_gmt\\";
	let mode	.= $procName;
	var param	= call_user_func([mode,"param"]);

	if !empty(param) {
		var valid	= call_user_func_array(["\\svc\\param","validate_args_types"],[args,param]);

		if valid !== true {
			return false;
		}
	}

	var conn	= call_user_func_array([mode,"conn"],[args]);
	var db		= call_user_func_array([mode,"db"],[args]);
	var sql		= call_user_func_array([mode,"sql"],[args]);

	if !sql {
		return NULL;
	}

	var grid	= DbDeal::query(conn,db,sql);

	var result	= call_user_func_array([mode,"result"],[grid,Db::getDbLink()]);

	return result;
}



}
