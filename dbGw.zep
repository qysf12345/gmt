//<?
namespace Gmt;
class DbGw
{

public	static	function run(string procName, string gameWorldId, args)
{
	string mode	= "\\mode\\db_gw\\";
	let mode	.= $procName;
	var param	= call_user_func([mode,"param"]);

	if !empty(param) {
		var valid	= call_user_func_array(["\\svc\\param","validate_args_types"],[args,param]);

		if valid !== true {
			return NULL;
		}
	}

	if !call_user_func_array(["\\svc\\type", "validate"], [gameWorldId,["game_world_id_text"]]) {
		return NULL;
	}

	var gameWorld = call_user_func_array(["\\adm\\game_world","fetch"],[gameWorldId]);

	if !gameWorld {
		return NULL;
	}

	var conn	= call_user_func_array([mode,"conn"],[gameWorldId, gameWorld, args]);
	var db		= call_user_func_array([mode,"db"],[gameWorldId, gameWorld,args]);
	var sql		= call_user_func_array([mode,"sql"],[gameWorldId, gameWorld,args]);

	if !sql {
		return NULL;
	}

	var grid	= DbDeal::query(conn,db,sql);

	var result	= call_user_func_array([mode,"result"],[grid,Db::getDbLink()]);

	return result;
}



}
