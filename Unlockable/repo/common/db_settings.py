try:
    import json
    with open('/home/dotcloud/environment.json') as f:
        env = json.load(f)
    import sys
    sys.path.append('/home/dotcloud/current')

    if 'DOTCLOUD_DATA_PGSQL_LOGIN' not in env:
        env['DOTCLOUD_DATA_PGSQL_LOGIN'] = "unlockable"
    if 'DOTCLOUD_DATA_PGSQL_PASSWORD' not in env:
        env['DOTCLOUD_DATA_PGSQL_PASSWORD'] = "unlockme"


except:
    env = {}
    env['DOTCLOUD_DATA_PGSQL_LOGIN'] = "unlockable"
    env['DOTCLOUD_DATA_PGSQL_PASSWORD'] = "unlockme"
    env['DOTCLOUD_DATA_PGSQL_HOST'] = "localhost"
    env['DOTCLOUD_DATA_PGSQL_PORT'] = 5432
    env['PORT_WWW'] = 6767
    env["DOTCLOUD_CACHE_REDIS_PORT"]=  6379
    env["DOTCLOUD_CACHE_REDIS_PASSWORD"] = ""
    env["DOTCLOUD_CACHE_REDIS_HOST"] = "localhost"
    redis_loginpasshost = env["DOTCLOUD_CACHE_REDIS_HOST"]

db_uri = "postgresql://%s:%s@%s:%s/unlockable" % (env['DOTCLOUD_DATA_PGSQL_LOGIN'],
                                                  env['DOTCLOUD_DATA_PGSQL_PASSWORD'],
                                                  env['DOTCLOUD_DATA_PGSQL_HOST'],
                                                  env['DOTCLOUD_DATA_PGSQL_PORT'],
                                                  )
redis_port = env["DOTCLOUD_CACHE_REDIS_PORT"]
redis_password = env["DOTCLOUD_CACHE_REDIS_PASSWORD"]
redis_host = env["DOTCLOUD_CACHE_REDIS_HOST"]

#redis caches
CACHEDB = 0
ANALYTICSDB = 1




#"DOTCLOUD_CACHE_REDIS_URL": "redis://root:btNWmSAN2vL88LwP6zzX@zombies-bbeecher.azva.dotcloud.net:35325",
# "DOTCLOUD_CACHE_REDIS_LOGIN": "root",
#     "DOTCLOUD_CACHE_REDIS_PORT": "35325",
#     "DOTCLOUD_CACHE_REDIS_PASSWORD": "btNWmSAN2vL88LwP6zzX",
#     "DOTCLOUD_CACHE_REDIS_HOST": "zombies-bbeecher.azva.dotcloud.net"





# DOTCLOUD_WWW_HTTP_HOST: The host where your server is running;
# DOTCLOUD_WWW_HTTP_URL: The url were your tornado server is accessible (shown at the end of `dotcloud push`)
