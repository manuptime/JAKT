#!/usr/bin/env python
from sqlalchemy import create_engine
from db_settings import db_uri
import models
from session import Session, make_session
import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument("game_ids", help="the ids of the games we want to backup",
                    type=int,  nargs='+')


args = parser.parse_args()
engine = create_engine(db_uri)
make_session(echo=False)
s = Session()

print "pulling games"
data = s.query(models.Game).filter(models.Game.id.in_(args.game_ids))
json_data = json.dumps(list(data), cls=models.new_alchemy_encoder(False, ["campaign", "commercial", "frames", "questions", "answers"], ['plays']), check_circular=False)

import datetime

key = datetime.datetime.strftime(datetime.datetime.now(),"games-%Y-%m-%d_%H:%M:%S.json")

from io import BytesIO
content = BytesIO(json_data)

from s3 import move_file_to_s3
print "moving file to s3"
move_file_to_s3(key, content, "unlockable-backup")
print "FILES BACKED UP TO: %s" % key
