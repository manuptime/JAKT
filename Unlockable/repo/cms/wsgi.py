import sys
sys.path.append('/home/dotcloud/current')
from cms import app as application
from common.session import make_session

make_session()
application.debug = True
