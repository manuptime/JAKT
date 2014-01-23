Originally posted on [Setting up Unlockable Dev](https://github.com/Unlockable/Unlockable/wiki/Setting-up-unlockable-dev-env)

1. Install pip

2. Install Virtual Environment and virtual env wrapper

    http://roundhere.net/journal/virtualenv-ubuntu-12-10/ (no longer need to modify your bashrc)

        $ sudo apt-get install python-virtualenv
        $ sudo apt-get install virtualenvwrapper


3. Install postgresql-dev

        $ sudo apt-get install postgresql-dev-X.Y postgresql-contrib

4. Install gevent and libevent-dev

        $ sudo apt-get install python-gevent
        $ sudo apt-get install libevent-dev


5. Create virtualenv

        $ mkvirtualenv unlockable

6. Install packages from base, api, and cms

        $ pip install -r requirements.txt
        $ pip install -r api/requirements.txt
        $ pip install -r cms/requirements.txt

7. Install packages for compiling templates in client

        $ pip install watchdog
        $ npm -g install https://github.com/gabrielgrant/node-ember-precompile/tarball/master

8. Create database

        $ cd common
        $ createuser unlockable -P # use unlockme as password
        $ createdb unlockable -O unlockable --encoding=UTF8
        $ python create_db.py


9. Import data from a recent backup. Log into S3 and download a pgdump from prod, or create one on qa/dev and import that, via psql unlockable < YOUR_BACKUP.

10. Start api server

        $ cd api/
        $ python api.py

11. Start static server

        $ cd client
        $ python -m python -m SimpleHTTPServer

12. Browse to [localhost:8000](http://localhost:8000) and enjoy!
