from __future__ import absolute_import

from celery.schedules import crontab
from celery.decorators import periodic_task
from celery.utils.log import get_task_logger
from datetime import datetime
from campaigns.models import Campaign, Category
from campaigns.scrapers import KickstarterScraper


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
    KICKSTARTER_CATEGORIES = ['art', 'comics', 'crafts', 'dance', 'design', 'fashion', 'film & video', 'food', 'games', 'journalism', 'music', 'photography', 'publishing', 'technology', 'theater']
    projects = []
    scraper = KickstarterScraper

    last_updated = datetime.utcnow()

    for category in KICKSTARTER_CATEGORIES:
        logger.info("Kickstarter processing category " + category)
        projects += scraper.find_projects(category, paginate=True)

    projects = map(lambda p: {'name': p.get('name'),
                                'deadline': datetime.utcfromtimestamp(p.get('deadline')),
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
    logger.info("Kickstarter scraper - Bulk creating")
    Campaign.objects.bulk_create(projects)
    logger.info("Saved latest almost funded projects from Kickstarter")