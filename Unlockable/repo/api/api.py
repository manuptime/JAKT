
from gevent.monkey import patch_all
from gevent_psycopg2 import monkey_patch
monkey_patch()
patch_all()

import signal
import sys
import boto

from brubeck.request_handling import Brubeck
from brubeck.connections import WSGIConnection

from common.db_settings import env
from common.session import make_session
import views


options = {
    "handler_tuples" : [
        (r'^/beta/initial/$', views.InitialHandshake),
        (r'^/beta/moregames/$', views.MoreGames),
        (r'^/beta/modelopen/$', views.ModalOpened),
        (r'^/beta/gamefinished/$', views.GameFinished),
        (r'^/beta/gamestart/$', views.GameStarted),
        (r'^/beta/analytics/$', views.AnalyticEvent),
        (r'^/beta/unlock/$', views.UnlockContent),
        (r'^/beta/error/$', views.Error),
        ],
    'msg_conn': WSGIConnection(port=env['PORT_WWW']),
}

import logging
import logging.handlers



from common.seslogginghandler import SESHandler
from common.aws import AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET
ses_handler = SESHandler(AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET, "server@unlockable.com",
                         [
                             "ben@unlockable.com",
                             "unlockableapicb@gmail.com",
                             "unlockableapizg@gmail.com",
                         ],
                         "API MESSAGE")


app = Brubeck(**options)

app.DEBUG = views.DEBUG

if not app.DEBUG:
    logger = logging.getLogger()
    logger.addHandler(ses_handler)
    logger.setLevel(logging.ERROR)
    #turn off boto so we don't get into a recursive loop with error reporting (email about email breaking)
    boto_logger = logging.getLogger('boto')
    boto_logger.setLevel(logging.CRITICAL)



from brubeck.request_handling import render

@app.add_route('^/mu-55e0c9b0-a5c8fca3-4a0e2731-51a62d59', method='GET')
def blitz(application, message):
    return render('42', 200, 'OK', {})

@app.add_route('^/CloudHealthCheck', method=['HEAD', 'GET'])
def cloudhealthcheck(application, message):
    """handle dotclouds cloud health check without throwing a ton of errors"""
    return render('42', 200, 'OK', {})


# Callback called when you run `supervisorctl stop'
def sigterm_handler(signum, frame):
    sys.exit(0)

if __name__ == "__main__":
    make_session(echo=False)
    signal.signal(signal.SIGTERM, sigterm_handler)
    app.run()
