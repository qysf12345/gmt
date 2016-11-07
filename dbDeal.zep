//<?
namespace Gmt;
class DbDeal
{

public	static	function query(array conn, string db, string sql)
{
	var result = Db::queryi(conn,db,sql);

	if is_null(result) {
		return NULL;
	}

	if is_bool(result) {
		return result;
	}

	var grid = [];

	var rowCount = mysqli_num_rows(result);

	if rowCount < 1 {
		return [];
	}

	mysqli_data_seek(result, 0);

	int i;

	for i in range(0, rowCount - 1) {
		let grid[i] =  mysqli_fetch_assoc(result);
	}
	v(rowCount, grid, 1);

	return grid;
}



}
