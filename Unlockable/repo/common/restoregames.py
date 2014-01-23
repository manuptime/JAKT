#!/usr/bin/env python
from sqlalchemy import create_engine
from db_settings import db_uri
import models
from session import Session, make_session
import argparse
import json
import requests

parser = argparse.ArgumentParser()
parser.add_argument("game_path", help="the key of the file to download and restore from")



args = parser.parse_args()
engine = create_engine(db_uri)
make_session(echo=False)
s = Session()

print "pulling games"

import urllib
path = urllib.quote_plus(args.game_path.strip())
r = requests.get('https://s3.amazonaws.com/unlockable-backup/' +path )

json_data = r.content
data = json.loads(json_data)

local_commercial = {}
local_campg = {}

for game in data:
    commercial_id = game['commercial_id']
    commercial = game['commercial']
    campaign = commercial['campaign']
    campaign_id = commercial['campaign_id']


    del game['id']
    del game['commercial_id']
    del game['commercial']
    del game['plays']

    del commercial['campaign_id']
    del commercial['campaign']
    del commercial['id']
    del commercial['games']

    del campaign['id']
    del campaign['commercials']


    commercial_name = commercial['name']
    print "commercial:   "+ commercial_name
    comm = s.query(models.Commercial).filter_by(name=commercial_name).first()

    if comm:
        c = comm.campaign

    else:

        if campaign_id in local_campg:
            c = local_campg[campaign_id]
        else:
            c = models.Campaign(**campaign)
            local_campg[campaign_id] = c
            s.add(c)


        if commercial_id in local_commercial:
            comm = local_commercial[commercial_id]
        else:
            comm = models.Commercial(**commercial)
            local_commercial[commercial_id] = comm
            comm.campaign = c
            s.add(comm)



    if game['game_type'] == 'frames':
        frames = game['frames']
        del game['frames']
        g = models.Frames(**game)
        for frame in frames:
            del frame['id']
            del frame['game_id']
            ff = models.Frame(**frame)
            ff.game = g
            s.add(ff)

    elif game['game_type'] == 'trivia':
        questions = game['questions']
        del game['questions']
        g = models.Trivia(**game)
        for question in questions:
            answers = question['answers']
            del question['answers']
            del question['id']
            del question['game_id']
            q = models.Question(**question)
            for answer in answers:
                del answer['id']
                del answer['question_id']
                del answer['question']
                a = models.Answer(**answer)
                a.question = q
            q.trivia = g


    elif  game['game_type'] == 'puzzle':
        g = models.Puzzle(**game)

    g.commercial = comm

    s.add(g)

s.commit()
print "games commited"
