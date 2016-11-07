//<?
namespace Gmt;
class Cached
{
private	static	instance = NULL;

private static function getInstance()
{
    if typeof(self::instance) != "object"
    {
        var instance;
		let instance = new \Memcache;
        if instance->connect("localhost", 11211) != true
		{
            return false;
		}

        let self::instance = instance;
    }
    return true;
}

public	static	function set(key, value, int zlib=0, int expire = 0)
{
	if self::getInstance() == false {
		return false;
	}

	string vtype = typeof(value);

	if vtype == "array" || vtype == "object" {
		return self::instance->set(key, serialize(value), zlib ? MEMCACHE_COMPRESSED : 0, expire);
	}

	 return self::instance->set(key, value, zlib ? MEMCACHE_COMPRESSED : 0, expire);
}

public	static	function get(key, int v=0)
{
	if self::getInstance() == false {
		return false;
	}
	return self::instance->get(key, v);
}


public	static	function add(key, value, int expire=0)
{
	if self::getInstance() == false {
		return false;
	}

	string vtype = typeof(value);

	if vtype == "array" || vtype == "object" {
		return self::instance->add(key, serialize(value), 0, expire);
	}

	return self::instance->add(key, value, 0, expire);
}

public	static	function replace(key, value, int expire=0)
{
	if self::getInstance() == false {
		return false;
	}

	string vtype = typeof(value);

	if vtype == "array" || vtype == "object" {
		return self::instance->replace(key, serialize(value), 0, expire);
	}

	return self::instance->replace(key, value, 0, expire);
}

public	static	function delete(key)
{
	if self::getInstance() == false {
		return false;
	}

	return self::instance->delete(key);

}

public	static	function flush()
{
	if self::getInstance() == false {
		return false;
	}

	return self::instance->flush();
}


}
