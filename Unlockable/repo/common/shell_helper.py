from sqlalchemy import create_engine
from db_settings import db_uri
import models
from session import Session, make_session
import argparse
import json


engine = create_engine(db_uri)
make_session(echo=False)
s = Session()
