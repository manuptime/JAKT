import sys
sys.path.append('/home/dotcloud/current')

from api import app as application
from api import make_session, patch_all

make_session()
patch_all()
