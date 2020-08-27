#!/usr/bin/env python
import os, sys


if (sys.version_info < (3, 0)):
    print('PcGs-finder uses Python3')
    sys.exit(1)

os.system('pip3 install -r ./requirements.txt')

db_path = './DBs/'

if not os.path.exists(db_path):
    os.system('wget -v https://www.dropbox.com/sh/d4i7xg2pwpmpmmh/AABGQ0h8mnmRyGM6-nJos0sQa?dl=0 --content-disposition')
    os.system('unzip ./DBs.zip -d DBs')
    os.system('rm ./DBs.zip')

if not os.path.exists(os.path.join(db_path, 'Pf_Sm.h3i')):
    os.system('hmmpress %s' % (os.path.join(db_path, 'Pf_Sm')))
    print ('domains database downloaded')
else:
    print ('Pf_Sm exists')

if not os.path.exists(os.path.join(db_path, 'eggnog.db')):
    os.system('wget -v http://eggnog5.embl.de/download/emapperdb-5.0.0/eggnog.db.gz -P %s' % (db_path))
    os.system('gunzip %seggnog.db.gz' % (db_path))
    print ('eggnog database downloaded')
else:
    print ('eggnog database exist')

print ('PcGs-finder is ready to use')