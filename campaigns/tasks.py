from __future__ import absolute_import

from celery.schedules import crontab
from celery.decorators import periodic_task
from celery.utils.log import get_task_logger
# from djcelery.models import PeriodicTask
from datetime import datetime
from campaigns.models import Campaign, Category
from campaigns.scrapers import KickstarterScraper

from campaigns.utils import task_scrape_latest_kickstarter

__author__ = 'lorenamesa'

logger = get_task_logger(__name__)


@periodic_task(
    run_every=(crontab(minute='*/15')),
    name="task_scrape_latest_kickstarter",
    ignore_result=True
)
def task_scrape_latest_kickstarter():
    """
    Saves latest almost funded projects from Kickstarter
    """
    # task_scrape_latest_kickstarter()
    KICKSTARTER_CATEGORIES = ['Art', 'Comics', 'Crafts', 'Dance', 'Design', 'Fashion', 'Film & Video', 'Food', 'Games', 'Journalism', 'Music', 'Photography', 'Publishing', 'Technology', 'Theater']
    projects = []
    scraper = KickstarterScraper
    print "here I am!"
    last_updated = datetime.utcnow()

    for category in KICKSTARTER_CATEGORIES:
        print "processing category ", category
        projects += scraper.find_projects(category, paginate=True)
    print "mapping into Campaigns"
    projects = map(lambda p: {'name': p.get('name'),
                                'deadline': p.get('deadline'),
                                'goal': p.get('goal'),
                                'raised': p.get('pledged'),
                                'url': p.get('urls', {}).get('web', {}).get('project', 'N/A'),
                                'description': p.get('blurb'),
                                'last_updated': last_updated,
                                'recipient': p.get('location', {}).get('urls', {}).get('web', {}).get('location', 'N/A'),
                                'creator': p.get('creator', {}).get('name', 'N/A'),
                                'location': p.get('location', {}).get('short_name', 'N/A'),
                                'category': Category.objects.get_or_create(category=p.get('category', {}).get('slug', 'N/A'))[0]}, projects)

    projects = map(lambda p: Campaign(**p), projects)
    print "Bulk creating"
    Campaign.objects.bulk_create(projects)
    logger.info("Saved latest almost funded projects from Kickstarter")

@periodic_task(
    run_every=(crontab(minute='*/15')),
    name="task_add",
    ignore_result=True
)
def task_add(a,b):
    return a + b