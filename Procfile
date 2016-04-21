web: gunicorn almostfunded.wsgi:application --log-file -
worker: celery -A almostfunded worker -B --without-gossip --without-mingle --without-heartbeat
