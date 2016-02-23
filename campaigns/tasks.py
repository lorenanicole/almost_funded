from __future__ import absolute_import
from bulk_update.helper import bulk_update

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
    # TODO: Dedup logic ensuring unique projects added - http://stackoverflow.com/questions/17311059/django-bulk-create-ignore-duplicates
    # TODO: Use Q objects? http://stackoverflow.com/questions/24502658/django-get-or-create-performance-optimization-for-a-list-of-objects

    KICKSTARTER_CATEGORIES = ['art', 'comics', 'crafts', 'dance', 'design', 'fashion', 'film & video', 'food', 'games', 'journalism', 'music', 'photography', 'publishing', 'technology', 'theater']
    projects = []
    scraper = KickstarterScraper

    last_updated = datetime.utcnow()
    project_urls = set([])

    for category in KICKSTARTER_CATEGORIES:
        logger.info("Kickstarter processing category " + category)
        projects += scraper.find_projects(category, paginate=True)

    project_data_map = {p.get('urls', {}).get('web', {}).get('project', 'N/A'): p for p in projects}

    project_urls |= project_data_map.keys()

    existing = list(Campaign.objects.filter(url__in=project_urls))  # .values_list('id', flat=True)

    projects = filter(lambda p: p.get('urls', {}).get('web', {}).get('project', 'N/A') not in existing, projects)

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

    logger.info("Kickstarter scraper - Bulk creating")

    projects = map(lambda p: Campaign(**p), projects)
    Campaign.objects.bulk_create(projects)

    logger.info("Kickstarter scraper - Bulk update")

    for project in existing:
        project.goal = project_data_map[project.url].get('goal')
        project.last_updated = last_updated
        project.deadline = datetime.utcfromtimestamp(project_data_map[project.url].get('deadline'))

    bulk_update(existing)

    logger.info("Saved latest almost funded projects from Kickstarter")