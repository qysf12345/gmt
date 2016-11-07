//<?
namespace Gmt;
class Master
{
	public static function handleRequest( string r )
	{
		string handler = "\\mode\\rh\\";
		let handler .= r;
		{handler}::handle();
	}
}
