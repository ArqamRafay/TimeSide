#!/bin/sh

# paths
app_dir='/opt/TimeSide/'
sandbox_dir='/home/timeside/'
manage=$sandbox_dir'manage.py'

python $manage syncdb --noinput
python $manage migrate --noinput
python $manage collectstatic --noinput
python $manage timeside-create-admin-user

# Starting celery worker with the --autoreload option will enable the worker to watch for file system changes
# This is an experimental feature intended for use in development only
# see http://celery.readthedocs.org/en/latest/userguide/workers.html#autoreloading
$manage celery worker --autoreload -A celery_app
