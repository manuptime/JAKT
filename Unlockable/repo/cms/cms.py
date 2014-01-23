import re
from datetime import datetime, time
import time
from flask import Flask
from flask.ext  import wtf
from flask.ext.admin import Admin, BaseView
from flask.ext.admin.model import InlineFormAdmin
from flask.ext.admin.contrib.sqlamodel import ModelView
from flask.ext.admin.contrib.sqlamodel.form import InlineModelConverter, InlineModelConverter

from common.session import make_session
from common.s3 import move_file_to_s3, ENCODING_BUCKET, BUCKET_NAME, encode_video

from common import models

from flask.ext.sqlalchemy import SQLAlchemy

from common.db_settings import env, db_uri



app = Flask(__name__)
app.config['SECRET_KEY'] = '123456790'
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
app.config['SQLALCHEMY_ECHO'] = True


db = SQLAlchemy(app)

admin = Admin(app, name="Unlockable")
# Add administrative views here

#TODO
#screen showing a campagin and all commercials with in it
#move commercial into inline form for campaign

UPLOADS_DIR = 'uploads/{0}/{1.year:04}/{1.month:02}/{1.day:02}/{2}/{3}'


def file_url(name):
    def inner(filename):
        r = re.compile(r'[^\S]')
        filename = r.sub('', filename)
        now = datetime.now()
        timestamp = int(time.time())
        return  UPLOADS_DIR.format(name, now, timestamp, filename)
    return inner

# class FileView(ModelView):

#     file_fields = {}

#     def __new__(cls, *args, **kwargs):
#         overrides = cls.form_overrides or {}
#         for field in cls.file_fields.keys():
#             overrides[field] = wtf.FileField
#         if not cls.form_overrides:
#             cls.form_overrides = overrides
#         return super(FileView, cls).__new__(cls, *args, **kwargs)


#     def pre_model_change(self, form, model):
#         for field, func in self.file_fields.iteritems():
#             formfield = getattr(form, field)
#             file = formfield.data
#             # do something with the file
#             getattr(form, field).data = path

class PolyView(ModelView):
    form_excluded_columns = ('game_type','id')


class CommercialView(ModelView):

    form_excluded_columns = ('video',"brand_image")
    get_video_path =  staticmethod(file_url('commercial'))
    get_logo_path =  staticmethod(file_url('logo'))


    def scaffold_form(self):
        form_class = super(CommercialView, self).scaffold_form()
        form_class.video_file = wtf.FileField('Video')
        form_class.logo_file = wtf.FileField('Logo')
        return form_class

    def on_model_change(self, form, model):
        file = form.video_file.file
        if file:
            file_path = self.get_video_path(file.filename)
            key = move_file_to_s3(file_path, file, bucket_name=ENCODING_BUCKET, zip=False)
            encode_video(key)
            model.video = file_path
        file = form.logo_file.file
        if file:
            file_path = self.get_logo_path(file.filename)
            move_file_to_s3(file_path, file)
            model.brand_image = file_path


class TriviaView(PolyView):
    inline_models = (models.Question,)

class QuestionView(ModelView):
    inline_models = (models.Answer,)

class FrameInline(InlineFormAdmin):
    form_excluded_columns = ['image_path',]

    def postprocess_form(self, form):

        def handle_image(self, obj, name):
            if not self.image.file:
                return
            file = self.image.file
            get_frame_path = file_url('frame')
            file_path = get_frame_path(file.filename)
            move_file_to_s3(file_path, file)
            obj.image_path = file_path


        form.image = wtf.FileField('Frame Image')
        form.postprocess_obj = handle_image
        return form


class FramesView(PolyView):
    inline_models = (FrameInline(models.Frame),)

class FrameView(ModelView):
    form_excluded_columns = ('image_path',)

    get_frame_path =  staticmethod(file_url('frame'))

    def scaffold_form(self):
        form_class = super(FrameView, self).scaffold_form()
        form_class.image = wtf.FileField('Frame Image')
        return form_class

    def on_model_change(self, form, model):
        file = form.image
        file_path = self.get_frame_path(file.filename)
        move_file_to_s3(file_path, file)
        model.image_path = file_path




admin.add_view(ModelView(models.Campaign, db.session))
admin.add_view(ModelView(models.CampaignTarget, db.session))
admin.add_view(ModelView(models.Rapleaf, db.session))
admin.add_view(ModelView(models.ForeignUser, db.session))
admin.add_view(PolyView(models.Puzzle, db.session))
admin.add_view(PolyView(models.Dropblocks, db.session))
admin.add_view(CommercialView(models.Commercial, db.session))
admin.add_view(FrameView(models.Frame, db.session))
admin.add_view(FramesView(models.Frames, db.session))
admin.add_view(ModelView(models.Answer, db.session))
admin.add_view(QuestionView(models.Question, db.session))
admin.add_view(TriviaView(models.Trivia, db.session))



if __name__ == "__main__":
    make_session()
    app.debug = True
    app.run()

#Base.metadata.create_all(engine)
