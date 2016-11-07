//<?
namespace Gmt;
class DbConn
{
private static conn = ["host_name":"localhost","user_name":"gmt_monster","user_password":"gmt_monster"];

public	static	function get()
{
	return self::conn;
}
}
