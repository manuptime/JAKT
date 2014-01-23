import json
from datetime import  datetime
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base, DeclarativeMeta
from sqlalchemy.ext.mutable import MutableDict
from sqlalchemy.dialects.postgresql import HSTORE

from sqlalchemy import ForeignKey, Column, Integer, String, SmallInteger, Boolean, DateTime

Base = declarative_base()



class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    points = Column(Integer, default=0)
    active = Column(Boolean, default=False)
    taken_survey = Column(Boolean, default=False)

    def __repr__(self):
        return "User(id=%s)" % (self.id,)

class ForeignUser(Base):
    __tablename__ = "foreign_users"
    id = Column(Integer, primary_key=True)
    domain = Column(String(80), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", backref="foreign_users")
    hashed_email = Column(String(80))

    foreign_id = Column(String(80), nullable=False)

    def __repr__(self):
        return "%s %s" % (self.user_id, self.domain)


class Campaign(Base):
    """flesh this out more later"""
    __tablename__ = "campaign"
    id = Column(Integer, primary_key=True)
    brand = Column(String(256), nullable=False)
    commercials = relationship("Commercial", backref="campaign")
    count_uniques = Column(Integer())
    count_engagements = Column(Integer())
    quota_uniques = Column(Integer())
    quota_engagements = Column(Integer())
    flight_start = Column(DateTime)
    flight_end = Column(DateTime)
    industry = Column(String(30))

    def __repr__(self):
        return "%s" % (self.brand,)

    def __unicode__(self):
        return "%s" % (self.brand,)

    def __str__(self):
        return "%s" % (self.brand,)


class CampaignTarget(Base):
    __tablename__ = "campaign_target"
    id = Column(Integer, primary_key=True)
    campaign_id = Column(Integer, ForeignKey("campaign.id"), nullable=False)
    age = Column(String(5))
    gender = Column(String(6))
    children = Column(String(3))
    zip = Column(String(5))
    household_income = Column(String(22))
    new_players_only = Column(Boolean, default=False)
    pets = Column(Boolean, default=False)

    def __repr__(self):
        return "%s %s" % (self.age, self.gender)

    def __unicode__(self):
        return "%s %s" % (self.age, self.gender)

    def __str__(self):
        return "%s %s" % (self.age, self.gender)



class Commercial(Base):
    __tablename__ = "commercial"
    name = Column(String(256), nullable=False)
    id = Column(Integer, primary_key=True)
    video = Column(String(256), nullable=False)
    campaign_id = Column(Integer, ForeignKey('campaign.id'))
    brand_image = Column(String(256), nullable=False)
    count_uniques = Column(Integer())
    count_engagements = Column(Integer())
    quota_engagements = Column(Integer())
    quota_uniques = Column(Integer())

    def __repr__(self):
        return "%s" % (self.name,)
    def __str__(self):
        return "%s" % (self.name,)
    def __unicode__(self):
        return "%s" % (self.name,)


class Sitting(Base):
    __tablename__ = 'sitting'
    id = Column(Integer, primary_key=True)
    get_inventory = Column(DateTime, nullable=False)
    modal_award = Column(DateTime)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    foreign_id = Column(Integer, ForeignKey("foreign_users.id"), nullable=False)
    modal_open = Column(DateTime)
    user_agent = Column(String(256))


    #TODO - add site id
    #TODO - offer id

    user = relationship("User", backref="sittings")
    foreign_user = relationship("ForeignUser", backref="sittings")

    def __unicode__(self):
        return "user:%s played at:%s from  %s to %s " % (self.user_id,self.foreign_user.domain, self.get_inventory, self.modal_award )


class GamePlay(Base):
    """A single playthrough of a game"""
    __tablename__ = "gameplay"
    id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    user = relationship("User", backref="gameplays")

    time_start = Column(DateTime)
    time_end = Column(DateTime)
    sitting_id = Column(Integer, ForeignKey("sitting.id"), nullable=False)
    points = Column(Integer)
    game_id = Column(Integer, ForeignKey("game.id"), nullable=False)
    game = relationship("Game", backref="plays")
    sitting = relationship("Sitting", backref="games")
    timer = Column(Integer)
    actions = Column(Integer)

    def __repr__(self):
        return "%s played %s and earned %s"


class Unlock(Base):
    __tablename__ = "unlock"
    id = Column(Integer, primary_key=True)
    prize_id = Column(Integer, ForeignKey("prize.id"), nullable=False)
    sitting_id = Column(Integer, ForeignKey("sitting.id"), nullable=False)
    prize = relationship("Prize", backref="unlocks")
    timestamp = Column(DateTime, default=datetime.utcnow())
    destination = Column(String(80), nullable=False) #the end point we're sending to
    cost = Column(Integer)

class Prize(Base):
    __tablename__ = "prize"
    id = Column(Integer, primary_key=True)
    domain_id = Column(Integer, ForeignKey("domain.id"), nullable=False)
    domain = Column(String(80), nullable=False)
    description = Column(String(255), nullable=False)
    cost = Column(Integer)

# class Playlist(Base):
#     id = Column(Integer, primary_key=True)
#     order = Column(Integer)
#     game_in_list_id = Column(Integer, ForeignKey('commercial.id'), nullable=False)
#     game = relationship("Game", backref="games")

class Domain(Base):
    __tablename__ = "domain"
    id = Column(Integer, primary_key=True)
    domain = Column(String(255), nullable=False)
    context = Column(String(255), nullable=True)


class Game(Base):
    __tablename__ = "game"
    id = Column(Integer, primary_key=True)
    game_type = Column(String(20))
    commercial_id = Column(Integer, ForeignKey('commercial.id'), nullable=False)
    commercial = relationship("Commercial", backref="games")
    active = Column(Boolean, default=False)

    play_order = Column(SmallInteger)

    __mapper_args__ = {'polymorphic_on': game_type}


    def __unicode__(self):
        return "%s %s" % (self.commercial, self.game_type)
    def __str__(self):
        return "%s %s" % (self.commercial, self.game_type)
    def __repr__(self):
        return "%s %s" % (self.commercial, self.game_type)


class Frame(Base):
    __tablename__ = "frame"
    id = Column(Integer, primary_key=True)
    image_path = Column(String(256), nullable=False)
    order = Column(SmallInteger, nullable=False)
    game_id = Column(Integer, ForeignKey('frames.id'))

    def __repr__(self):
        return "%s %s" % (self.order, self.image_path)

class Frames(Game):
    __tablename__ = "frames"
    __mapper_args__= {"polymorphic_identity":"frames"}

    id = Column(Integer, ForeignKey('game.id'), primary_key=True)
    frames = relationship("Frame", backref="game", order_by="Frame.order")


    def __repr__(self):
        return "%s" % (self.id,)


class Answer(Base):
    __tablename__ = "trivia_answer"
    id = Column(Integer, primary_key=True)
    answer = Column(String(256), nullable=False)
    correct = Column(Boolean, default=False, )
    question_id =Column(Integer, ForeignKey("trivia_question.id"))


    def __repr__(self):
        return "%s" % (self.answer,)

#TODO: figure out why this is broken, add in unique
#Index("one_right_answer", Answer.question_id, postgresql_where="trivia_answer.correct=True")


class Question(Base):
    __tablename__ = "trivia_question"
    id = Column(Integer, primary_key=True)
    question = Column(String(256), nullable=False)
    game_id = Column(Integer, ForeignKey("trivia.id"))

    answers = relationship("Answer", backref="question", order_by="Answer.id")

    def __repr__(self):
        return "%s" % (self.question,)
    def __unicode__(self):
        return "%s" % (self.question,)




class Trivia(Game):
    __tablename__ = "trivia"
    __mapper_args__ = {"polymorphic_identity":"trivia"}

    id = Column(Integer, ForeignKey("game.id"), primary_key=True)
    questions = relationship("Question", backref="trivia", order_by="Question.id")

    def __repr__(self):
        return "%s" % (self.id,)

class Puzzle(Game):
    __tablename__ = "puzzle"
    __mapper_args__ = {"polymorphic_identity":"puzzle"}
    id = Column(Integer, ForeignKey("game.id"), primary_key=True)

    def __repr__(self):
        return "%s" % (self.id,)

class Dropblocks(Game):
    __tablename__ = "dropblocks"
    __mapper_args__ = {"polymorphic_identity":"dropblocks"}
    id = Column(Integer, ForeignKey("game.id"), primary_key=True)

    def __repr__(self):
        return "%s" % (self.id,)




class AnalyticEvent(Base):
    __tablename__ = "analytic_events"
    id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    user = relationship("User", backref="analytics")

    sitting_id = Column(Integer, ForeignKey("sitting.id"), nullable=False)
    sitting = relationship("Sitting", backref="analytics")

    timestamp = Column(DateTime, nullable=False)
    event_type = Column(String(80), nullable=False)
    event_data = Column(MutableDict.as_mutable(HSTORE))

    #TODO  - add in domain
    #TODO  - add in offerid


class Rapleaf(Base):
    __tablename__ = "rapleaf"
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, primary_key=True)
    user = relationship("User", backref="rapleaf")
    age  = Column(String(5))
    gender = Column(String(6))
    zip = Column(String(5))
    occupation = Column(String(255))
    education = Column(String(255))
    household_income = Column(String(22))
    marital_status = Column(String(7))
    children = Column(String(3))
    pets = Column(Boolean, default=False)

class AlchemyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj.__class__, DeclarativeMeta):
            # an SQLAlchemy class
            fields = {}
            for field in [x for x in dir(obj) if not x.startswith('_') and x != 'metadata']:
                data = obj.__getattribute__(field)
                try:
                    json.dumps(data) # this will fail on non-encodable values, like other classes
                    fields[field] = data
                except TypeError:
                    fields[field] = None
            # a json-encodable dict
            return fields
        return json.JSONEncoder.default(self, obj)

def new_alchemy_encoder(revisit_self = False, fields_to_expand = [], fields_to_exclude=[]):
    """
    use like print json.dumps(e, cls=new_alchemy_encoder(False, ['parents']), check_circular=False)
    to expand fields called parents
    """
    _visited_objs = []
    class AlchemyEncoder(json.JSONEncoder):
        def default(self, obj):
            if isinstance(obj.__class__, DeclarativeMeta):
                # don't re-visit self
                if revisit_self:
                    if obj in _visited_objs:
                        return None
                    _visited_objs.append(obj)

                # go through each field in this SQLalchemy class
                fields = {}
                for field in [x for x in dir(obj) if not x.startswith('_') and x != 'metadata']:
                    if field in fields_to_exclude:
                        fields[field] = None
                        continue
                    val = obj.__getattribute__(field)

                    # is this field another SQLalchemy object, or a list of SQLalchemy objects?
                    if isinstance(val.__class__, DeclarativeMeta) or (isinstance(val, list) and len(val) > 0 and isinstance(val[0].__class__, DeclarativeMeta)):
                        # unless we're expanding this field, stop here
                        if field not in fields_to_expand:
                            # not expanding this field: set it to None and continue
                            fields[field] = None
                            continue

                    fields[field] = val
                # a json-encodable dict
                return fields

            return json.JSONEncoder.default(self, obj)
    return AlchemyEncoder

if __name__ == '__main__':
    from sqlalchemy import create_engine
    from db_settings import db_uri
    Base.metadata.create_all(create_engine(db_uri))
