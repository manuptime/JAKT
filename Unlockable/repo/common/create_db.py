from sqlalchemy import create_engine
from db_settings import db_uri
import models
from alembic.config import Config
from alembic import command

engine = create_engine(db_uri)
try:
    engine.execute("create extension hstore")
except:
    pass

models.Base.metadata.create_all(engine)
alembic_cfg = Config("alembic.ini")
command.stamp(alembic_cfg, "head")
