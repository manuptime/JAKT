from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

import redis

from db_settings import db_uri, redis_port, redis_password, redis_host, ANALYTICSDB, CACHEDB
Session = scoped_session(sessionmaker())


def make_session(db_uri=db_uri, echo=False):
    engine = create_engine(db_uri, echo=echo)
    engine.pool._use_threadlocal = True
    Session.configure(bind=engine)

def make_redis_pool(db=0, redis_host=redis_host, redis_port=redis_port, redis_password=redis_password):
    return redis.ConnectionPool(host=redis_host, port=redis_port,  password=redis_password, db=db)

AnalyticPool = make_redis_pool(ANALYTICSDB)
CachePool = make_redis_pool(CACHEDB)
