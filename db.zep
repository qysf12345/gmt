//<?
namespace Gmt;
class Db
{
public	static	dbLink;
private	static	dbMd5;
private	static	dbTime;

public	static	function getDbLink()
{
	return self::dbLink;
}

public	static	function queryi(var conn, string db, string sql)
{
	var hostName, userName, userPass, port, mysqli, result, e;
  
	let hostName	= conn["host_name"];
	let userName	= conn["user_name"];
	let userPass	= conn["user_password"];
	let	port		= 3306;

try{
	if !self::dbMd5 || self::dbMd5 != md5(hostName. "_" . userName . "_" . userPass . "_". db) {
		self::clearDbData();
		let mysqli = mysqli_init();

		if !mysqli {
			throw new \Exception( "mysql init err!! ");
		}

		mysqli->options(MYSQLI_OPT_CONNECT_TIMEOUT, 10);
		
		if !mysqli->real_connect(hostName, userName, userPass, db, port) {
			e(["mysql-connect",hostName,userName,"errno":mysqli->connect_errno,"error":mysqli->connect_error]);
			throw new \Exception("目标数据库链接异常，检查LOG先！<br>\n");
		}

		let self::dbLink = mysqli;
		let self::dbTime = time() + 60;
		let self::dbMd5	 = md5(hostName. "_" . userName . "_" . userPass . "_". db);
	} else {
		let mysqli = self::dbLink;
	}

	mysqli->set_charset("utf8");

	let result = mysqli->query(sql);

	if !result {
		self::clearDbData();
		e(["mysql-query",hostName,userName,"errno":mysqli->errno,"error":mysqli->error]);
		throw new \Exception("目标服务器sql执行失败，检查LOG先！<br>\n");
	}

	return result;
}
catch \Exception, e {
	echo e->getMessage();
}
	return false;
}

public	static	function clearDbData()
{
	if is_resource(self::dbLink) {
		mysqli_close(self::dbLink);
	}

	let self::dbMd5		= null;
	let self::dbTime	= null;
}

public	static	function mysqlConnectCheck(string hostName, string db, string userName, string userPass)
{
	var mysqli;
	let mysqli = mysqli_init();

	mysqli->options(MYSQLI_OPT_CONNECT_TIMEOUT, 5);

	if !mysqli->real_connect(hostName, userName, userPass) {
		e(["mysql check connect error",hostName,userName,"errno":mysqli->connect_errno,"error":mysqli->connect_error]);
		return false;
	}

	mysqli->set_charset("utf8");

	if !mysqli->select_db($db) {
		e(["mysql check select db err!", hostName,userName,"errno":mysqli->errno,"error":mysqli->error]);
		return false;
	}

	mysqli_close(mysqli);
	return true;
}



}
