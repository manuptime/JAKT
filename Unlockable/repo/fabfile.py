from move_to_s3 import sync_media_to_s3

from fabric import colors
from fabric.api import *
from fabric.contrib.project import *

import subprocess
import os
import shutil



env.app = ''
env.dest = "/var/www/%(app)s" % env
env.use_ssh_config = True
env.hosts = [""]
env.user = "ubuntu"

bucket_name = "unlockable"
aws_access_key_id = "AKIAJTHG75GEP44NPXMA"
aws_access_key_secret = "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"

cwd = os.getcwd()

aws_headers = {
    'Expires': 'Tue, 14 Aug 2013 20:00:00 GMT',
    'Cache-Control': "max-age:5, public",
}
cf_distribution_id = None

def sync_s3():
    sync_media_to_s3(bucket_name, aws_access_key_id, aws_access_key_secret,
                     aws_headers, cf_distribution_id, folder="client/media")

def build_client():
    build = os.path.join(cwd, 'client', 'build', 'build.sh')
    subprocess.call(build, shell=True)
    target_src = os.path.join(cwd, 'client', 'webapp-build', 'main.js')
    target_dest = os.path.join(cwd, 'client', 'media', 'scripts', 'unlockable.js')
    shutil.copy(target_src, target_dest)

def production():
    env.label = "production"

def reload_gunicorn():
    sudo("kill -HUP `cat /var/run/gunicorn/%(app)s.pid`" % env)

def start_gunicorn():
    with cd(env.dest):
        sudo("gunicorn_django -c gunicorn/%(label)s.py" % env)

def stop_gunicorn():
    sudo("kill `cat /var/run/gunicorn/%(app)s.pid`" % env)

def reload_nginx():
    print(colors.yellow("Reloading nginx"))
    sudo("kill -HUP `cat /var/run/nginx.pid`")

def shutdown_nginx():
    print(colors.red("Shutting down nginx"))
    sudo("kill -QUIT `cat /var/run/nginx.pid`")

def deploy():
    rsync()
    reload_gunicorn()

def rsync():
    print(colors.yellow("Deploying sources to %(host)s." % env))
    rsync_project(env.dest, ".", extra_opts="-FPOuhimrtyz")

def migrate():
    run(env.dest + "/manage.py migrate",)
