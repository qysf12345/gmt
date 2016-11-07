//<?php
namespace Gmt;
class Lock
{
private static	fpLock = 0;
private	static	fileLock;

public	static	function get( timeZone, suffix = "") -> boolean
{
	if timeZone < 0 || timeZone > 20 {
		return false;
	}
	
	string file = "/tmp/gmtools/file_lock_" . suffix;

	if is_dir("/tmp/gmtools") != 1 {
		mkdir("/tmp/gmtools");
	}

	var fp = fopen(file, "w");

	if fp == false {
		return false;
	}

	int i = timeZone * 10 /2 + 1;

	while i {
		if flock(fp, LOCK_EX | LOCK_NB) == true {
			let self::fpLock	= fp;
			let self::fileLock	= file;
			file_put_contents(file, "1");
			return true;
		}

		usleep(200000);
		let i--;
	}

	return false;
}

public	static	function release() -> void
{
	if self::fpLock != 0 {
		flock(self::fpLock, LOCK_UN);
		fclose(self::fpLock);
	}

	let self::fpLock = 0;

	if file_exists(self::fileLock) == true {
		unlink(self::fileLock);
	}
}

}
