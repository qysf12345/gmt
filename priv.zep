//<?
namespace Gmt;
class Priv
{
	private	static	maxPrivs 	= ["root":1,"op":2];
	private	static	topPrivs	= ["root":1,"op":2, "maintenance_one":3];
	private	static	middlePrivs	= ["root":1,"op":2, "maintenance_one":3, "maintenance_two":4, "plat_maintenance_one":5];

	public	static	function checkRootPriv(priv = "") -> boolean
	{
		if priv === "root" {
			return true;
		}
		return false;
	}

	public	static	function checkMaxPriv(priv = "") -> int
	{
		var value;
		if fetch value, self::maxPrivs[priv] {
			return value;
		}
		return 0;
	}

	public	static	function checkTopPriv(priv = "") -> int
	{
		var value;
		if fetch value, self::topPrivs[priv] {
			return value;
		}
		return 0;
	}

	public	static	function checkMiddlePriv(priv="") -> int
	{
		var	value;
		if fetch value, self::middlePrivs[priv] {
			return value;
		}

		return 0;
	}

	public	static	function checkPlatform(platformId)
	{
		
	}

	public	static	function getPlatformLimit(platformId)
	{
		if platformId !== "" && platformId !== "any" {
			return platformId;
		}

		return false;
	}

	public	static	function test_md5(string a)
	{
		int i = 10000;

		while i {
			md5(a);
			let i--;
		}

	}

	public	static	function getPassword(userId, password) -> string
	{
		string pass = "miyuezhzzd".userId.password;
		return pass->md5();
	}

	public	static	function checkPassword(opass,userId,password)
	{
		if self::getPassword(userId, password) === opass {
			return true;
		}

		string salt		= substr(password, 0, 2);
		var npass	= crypt(password, salt);

		if opass === npass {
			return true;
		}

		return false;
	}


}
