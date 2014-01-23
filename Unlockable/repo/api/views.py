import json
import md5
import datetime
from collections import OrderedDict

import requests

from sqlalchemy.sql.expression import func
from sqlalchemy.orm import joinedload
from sqlalchemy import desc, not_, asc


from brubeck.request_handling import JSONMessageHandler
from brubeck.auth import UserHandlingMixin as BrubeckUserHandler

from common.session import Session
from common import models

from rapleaf import get_rapleaf_data

def allow_all(func):
    def wrapper(self, *args, **kwargs):
        self.headers["Access-Control-Allow-Origin"] = "*"
        self.headers["Access-Control-Allow-Headers"] = "Content-Type"
        return func(self, *args, **kwargs)
    return wrapper

DEBUG = True

FREE_AWESOME_KEY = "972ht9epwme2l56hq0werh"

FREE_AWESOME_ENDPOINT = "http://freeawesome.com/postbacks/unlockable/"



# user_id (Our user's ID)
# offer_id (Your permeation that you pay on)
# cash (Amount of cash we are earning)
# currency (Amount of tokens we are awarding our user)
# signature (MD5 of concat offer_id and privateKey)
# ---PHP ON FA'S SIDE

    # $privateKey = "972ht9epwme2l56hq0werh";
    # $response = 0;

    # $user_id = $_REQUEST['user_id'];
    # $cash_amount = $_REQUEST['cash'];
    # $token_amount = $_REQUEST['currency'];
    # $offer_id = $_REQUEST['offer_id'];
    # $signature = $_REQUEST['signature'];

    # $my_signature = md5($offer_id . $privateKey);

    # if ($my_signature == $signature) {
    #     $response_good = 1;
    #     // Give award to user on our end
    # }
    # fclose($fh);

    # echo $response;


#our ghetto usercap, limit the number of users
USER_CAP = 600

def get_fa_games(sitting, s):
          #return games

    user_id = sitting.user.id

    active_user_count = int(s.query(models.User.id).filter(models.User.active==True).count())
    if sitting.user.active == False and active_user_count >= USER_CAP:
        return {}

    games_played = [gameplay.game_id for gameplay in s.query(models.GamePlay).filter_by(user_id=user_id).filter(models.GamePlay.time_start != None)]
    this_session = [gameplay.game_id for gameplay in s.query(models.GamePlay).filter_by(sitting_id=sitting.id)]

    games_played.extend(this_session)
    games = OrderedDict()

    # games['trivia'] = s.query(models.Trivia).options(joinedload('commercial')).order_by(desc(models.Trivia.active), func.random()).limit(1).first()
    # games['frames'] = s.query(models.Frames).options(joinedload('commercial')).order_by(desc(models.Frames.active), func.random()).limit(1).first()
    # games['puzzle'] = s.query(models.Puzzle).options(joinedload('commercial')).order_by(desc(models.Puzzle.active), func.random()).limit(1).first()


    # games['puzzle'] = s.query(models.Puzzle).options(joinedload('commercial')).order_by(desc(models.Puzzle.active),
    #                                                                                     asc(models.Puzzle.order).nullslast()).filter(not_(models.Puzzle.id.in_(games_played))).limit(1).first()

    # games['frames'] = s.query(models.Frames).options(joinedload('commercial')).order_by(desc(models.Frames.active),
    #                                                                                     asc(models.Frames.order).nullslast()).filter(not_(models.Frames.id.in_(games_played))).limit(1).first()

    # games['trivia'] = s.query(models.Trivia).options(joinedload('commercial')).order_by(desc(models.Trivia.active),
    #                                                                                     asc(models.Trivia.order).nullslast()).filter(not_(models.Trivia.id.in_(games_played))).limit(1).first()




    puzzles = s.query(models.Puzzle).filter_by(active=True).options(joinedload('commercial')).order_by(asc(models.Puzzle.play_order).nullslast())

    frames  = s.query(models.Frames).filter_by(active=True).options(joinedload('commercial')).order_by(asc(models.Frames.play_order).nullslast())

    trivia  = s.query(models.Trivia).filter_by(active=True).options(joinedload('commercial')).order_by(asc(models.Trivia.play_order).nullslast())
    dropblocks  = s.query(models.Dropblocks).filter_by(active=True).options(joinedload('commercial')).order_by(asc(models.Trivia.play_order).nullslast())


    if games_played != []:
        puzzles = puzzles.filter(not_(models.Puzzle.id.in_(games_played)))
        frames = frames.filter(not_(models.Frames.id.in_(games_played)))
        trivia = trivia.filter(not_(models.Trivia.id.in_(games_played)))
        dropblocks = dropblocks.filter(not_(models.Dropblocks.id.in_(games_played)))

    games['puzzle'] = puzzles.limit(1).first()
    games['frames'] = frames.limit(1).first()
    games['trivia'] = trivia.limit(1).first()
    #games['dropblocks'] = dropblocks.limit(1).first()


    for game in games.values():
        if not game:
            continue
        play = models.GamePlay(sitting_id=sitting.id,
                               game_id=game.id,
                               user_id=user_id,
                               )

        s.add(play)
    s.commit()

    return games

import logging
free_awesome_log = logging.getLogger('FA')
free_awesome_log.setLevel(logging.ERROR)

def unlock_free_awesome(user_id, offer_id):
    payload = {}
    payload['cash'] = 1.0 #???
    payload['currency'] = 40

    m = md5.new()
    m.update(str(offer_id))
    m.update(FREE_AWESOME_KEY)
    payload['signature'] = m.hexdigest()

    payload['offer_id'] = offer_id
    payload['user_id'] = user_id


    response = requests.post(FREE_AWESOME_ENDPOINT, data=payload)
    if response.status_code == 200:
        free_awesome_log.error(payload)
        return True
    else:
        free_awesome_log.error("got an error from FA: " + response.text)
        return False

class UserHandlingMixin(BrubeckUserHandler):

    def get_user(self, foreign_id=None, hashed_email=None):
        """
        Either finds or creates both a local user and a foreign user,
        also returns if the user is new or not
        """
        if foreign_id:
            foreign_user = self._get_foreign_user_from_id(foreign_id)
        else:
            foreign_user = self._get_foreign_user_from_request()
        try:
            get_rapleaf_data(hashed_email)
        except:
            free_awesome_log.error("error getting rapleaf data")

        if foreign_user:
            return foreign_user.user, foreign_user, False

        user = self.make_user()
        foreign_user = self.make_foreign_user(foreign_id, user, hashed_email)

        return user, foreign_user, True

    def make_user(self):
        user = models.User()
        self.s.add(user)
        self.s.commit()
        return user

    def make_foreign_user(self, foreign_id, user, hashed_email):
        """
        Makes a foreign user and links it to the user
        """
        domain = "freeawesome.com"
        foreign_user = models.ForeignUser(user_id=user.id, domain=domain, foreign_id=foreign_id, hashed_email=hashed_email)
        self.s.add(foreign_user)

        #rapleaf = models.Rapleaf(user_id=user.id, **get_rapleaf_data(hashed_email))
        #self.s.add(rapleaf)

        self.s.commit()
        return foreign_user


    def _get_foreign_user_from_id(self, foreign_id):
        # get foreign user or none
        foreign_user = self.s.query(models.ForeignUser).filter_by(foreign_id=unicode(foreign_id)).first()
        return foreign_user

    def _get_foreign_user_from_request(self):
        """ try to pull out the user from a cookie"""
        return False

    def get_current_user(self):
        user_id = self.get_cookie("user_id")
        if not user_id:
            user, foreign_user = self.get_foreign_and_local_user()
        else:
            pass
            #user = get user with user_id here
            #if not there:
              #blow cookie away
              #user, foreign_user = self.get_foreign_and_local_user()
        return user

    def get_current_userprofile(self):
        pass


class MoreGames(JSONMessageHandler, UserHandlingMixin):

    @allow_all
    def post(self):
        s = self.s = Session()
        payload = self.message.body
        payload = json.loads(payload)
        sitting_id = payload['sittingId']


        sitting = s.query(models.Sitting).get(sitting_id)


        #prepare return dict
        data = {}
        data['games'] = self.get_games(sitting)

        json_data = json.dumps(data, cls=models.new_alchemy_encoder(False, ["commercial", "frames", "questions", "answers"], ['plays']), check_circular=False)
        self.add_to_payload("data", json_data)
        s.close()
        return self.render(200)


    def get_games(self, sitting):
        return get_fa_games(sitting, self.s)

    @allow_all
    def options(self, *args, **kwargs):
        return super(MoreGames, self).options(*args, **kwargs)



class InitialHandshake(JSONMessageHandler, UserHandlingMixin):

    @allow_all
    def post(self):
        s = self.s = Session()
        payload = self.message.body
        user_agent = self.message.headers['HTTP_USER_AGENT']

        payload = json.loads(payload)
        foreign_id = payload['foreignId']
        hashed_email = payload.get('hashedEmail', None)

        user, foreign_user, new_user = self.get_user(foreign_id=foreign_id, hashed_email=hashed_email)

        #create sitting from user
        sitting = self.create_sitting(user.id, foreign_user.id, user_agent)


        #TODO: Add in user id to data

        #prepare return dict
        data = {}
        data['user'] = {'id':user.id,
                        'sitting': sitting.id,
                        'new_user':new_user,
                        'taken_survey': user.taken_survey,
                        }


        #get user data from thirdparty provider
        user_data = {}
        #get games
        data['games'] = self.get_inventory(user_data, user_id=user.id, sitting=sitting)

        #todo - replace with dynamic ids
        data['offer_id'] = 1
        json_data = json.dumps(data, cls=models.new_alchemy_encoder(False, ["commercial", "frames", "questions", "answers"], ['plays']), check_circular=False)
        self.add_to_payload("data", json_data)
        s.close()
        return self.render(200)

    def get_inventory(self, user_data, user_id, sitting):
        return get_fa_games(sitting, self.s)


    @allow_all
    def options(self, *args, **kwargs):
        return super(InitialHandshake, self).options(*args, **kwargs)

    def create_sitting(self, user_id, foreign_id, user_agent):
        sitting = models.Sitting()
        sitting.get_inventory = datetime.datetime.utcnow()
        sitting.user_id  = user_id
        sitting.foreign_id = foreign_id
        sitting.user_agent = user_agent
        #TODO - add site id

        self.s.add(sitting)
        self.s.commit()
        return sitting


class GameFinished(JSONMessageHandler, UserHandlingMixin):
    @allow_all
    def post(self):
        s = self.s = Session()
        payload = self.message.body
        payload = json.loads(payload)
        sitting_id = payload['sittingId']


        sitting = s.query(models.Sitting).get(sitting_id)

        play = s.query(models.GamePlay).filter_by(sitting_id=sitting.id, game_id=payload['gameId']).first()


        play.time_start=payload['timestart'],
        play.time_end=datetime.datetime.utcnow(),
        play.points=payload['points'],
        play.timer=payload['timer'],
        play.actions=payload['actions'],

        s.commit()
        s.close()
        return self.render(200)



    @allow_all
    def options(self, *args, **kwargs):
        return super(AnalyticEvent, self).options(*args, **kwargs)





class ModalOpened(JSONMessageHandler, UserHandlingMixin):
    @allow_all
    def post(self):
        payload = self.message.body
        payload = json.loads(payload)
        s = self.s = Session()

        if payload['userId'] == None:
            return self.render(500)

        sitting_id=payload['sittingId'],
        sitting = s.query(models.Sitting).get(sitting_id)
        sitting.modal_open = datetime.datetime.utcnow()

        s.add(sitting)
        s.commit()
        s.close()
        return self.render(200)

    @allow_all
    def options(self, *args, **kwargs):
        return super(ModalOpened, self).options(*args, **kwargs)



class GameStarted(JSONMessageHandler, UserHandlingMixin):
    @allow_all
    def post(self):
        payload = self.message.body
        payload = json.loads(payload)
        s = self.s = Session()

        if payload['userId'] == None:
            return self.render(500)

        sitting_id=payload['sittingId'],
        sitting = s.query(models.Sitting).get(sitting_id)

        play = s.query(models.GamePlay).filter_by(sitting_id=sitting.id, game_id=payload['gameId']).first()
        play.time_start=payload['timestart'],

        s.commit()
        s.close()
        return self.render(200)

    @allow_all
    def options(self, *args, **kwargs):
        return super(GameStarted, self).options(*args, **kwargs)



class Error(JSONMessageHandler):
    @allow_all
    def get(self):
        raise Exception("test error")




class AnalyticEvent(JSONMessageHandler, UserHandlingMixin):
    @allow_all
    def post(self):
        payload = self.message.body
        payload = json.loads(payload)
        s = self.s = Session()

        if payload['userId'] == None:
            return self.render(500)
        event = models.AnalyticEvent(user_id=payload['userId'],
                                     sitting_id=payload['sittingId'],
                                     timestamp=payload['timestamp'],
                                     event_type=payload['eventtype'],
                                     event_data={},
                                     )
        for key, value in payload['eventdata'].iteritems():
            event.event_data[key] = str(value)

        s.add(event)
        s.commit()
        s.close()
        return self.render(200)

    @allow_all
    def options(self, *args, **kwargs):
        return super(AnalyticEvent, self).options(*args, **kwargs)


class Error(JSONMessageHandler):
    @allow_all
    def get(self):
        raise Exception("test error")


class UnlockContent(JSONMessageHandler, UserHandlingMixin):
    @allow_all
    def post(self):
        #TODO - ensure this uses sync commit rather than the default of async
        s = self.s = Session()
        payload = self.message.body
        unlock_info = json.loads(payload)



        offer_id = unlock_info['offerId']
        user_id = unlock_info['userId']
        sitting_id = unlock_info['sittingId']


        #for FA
        completed_sessions = int(self.s.query(models.Sitting.id).filter(models.Sitting.user_id==user_id, models.Sitting.modal_award != None).count())
        offer_id = completed_sessions
        foreign_id = unlock_info['foreignId']


        sitting = s.query(models.Sitting).get(sitting_id)

        if not self.user_deserves_content(sitting):
            return self.render(403)

        sitting.modal_award = datetime.datetime.utcnow()


        user = s.query(models.User).get(user_id)
        user.active = True
        user.taken_survey = True
        s.add(user)
        s.commit()

        unlock_success = unlock_free_awesome(foreign_id, offer_id)
        s.close()
        if unlock_success:
            #TODO: create unlock model
            #models.Unlock()

            return self.render(200)
        else:
            return self.render(403)

    def user_deserves_content(self, sitting):
        if DEBUG:
            return False
        else:
            return True


    @allow_all
    def options(self, *args, **kwargs):
        return super(UnlockContent, self).options(*args, **kwargs)





#create redis connection pool in conf



# {eventtype: 'statetransition',
#  timestamp: 'asdf',
#  userid: 1,
#  eventdata: {
#           'from': 'statea'
#           'to': 'stateb'
#            }
#  }


# {eventtype: 'triviaanswer',
#  userid: 1,
#  timestamp: 'asdf'
#  eventdata: {
#           'chosen': '1' #question id
#           'correct': Boolean
#            }
#  }
