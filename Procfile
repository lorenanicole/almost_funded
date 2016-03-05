web: gunicorn almostfunded.wsgi:application --log-file -
worker: python manage.py celery worker -B -l info