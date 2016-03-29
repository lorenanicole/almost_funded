from __future__ import absolute_import
from bulk_update.helper import bulk_update

from celery.schedules import crontab
from celery.decorators import periodic_task
from celery.utils.log import get_task_logger
from datetime import datetime
from campaigns.models import Campaign, Category
from campaigns.scrapers import KickstarterScraper, GiveForwardScraper, GoFundMeScraper, CrowdRiseScraper


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

    for category in KICKSTARTER_CATEGORIES:
        print "Kickstarter processing category " + category
        logger.info("Kickstarter processing category " + category)
        projects += scraper.find_projects(category, paginate=True)

    project_data_map = {p.url: p for p in projects}

    project_urls = set(project_data_map.keys())

    existing = list(Campaign.objects.filter(url__in=project_urls))  # .values_list('id', flat=True)

    print "Kickstarter scraper - Bulk creating"
    logger.info("Kickstarter scraper - Bulk creating")

    projects = map(lambda p: Campaign(**p.to_dict()), projects)
    Campaign.objects.bulk_create(projects)
    print "Kickstarter scraper - Bulk update"
    logger.info("Kickstarter scraper - Bulk update")

    for project in existing:
        project.goal = project_data_map[project.url].get('goal')
        project.last_updated = project_data_map[project.url].get('last_updated')
        project.deadline = datetime.utcfromtimestamp(project_data_map[project.url].get('deadline'))
        project.raised = project_data_map[project.url].get('raised')

    bulk_update(existing)
    print "Saved latest almost funded projects from Kickstarter"
    logger.info("Saved latest almost funded projects from Kickstarter")


@periodic_task(
    run_every=(crontab(minute='*/15')),
    name="task_scrape_latest_gofundme",
    ignore_result=True
)
def task_scrape_latest_gofundme():
    """
    Saves latest almost funded projects from GoFundMe
    """
    # TODO: automate update of 'common' categories

    CATEGORIES = ['medical', 'volunteer', 'emergencies', 'education', 'memorials', 'sports', 'animals', 'creative', 'community', 'charity']
    categories = {}
    projects = []
    scraper = GoFundMeScraper

    for category in CATEGORIES:
        print "GoFundMe processing category " + category
        logger.info("GoFundMe processing category " + category)
        projects += scraper.find_projects(category, paginate=True)

    project_data_map = {}

    for p in projects:
        project_data_map[p.url] = p

    project_urls = set(project_data_map.keys())

    existing = list(Campaign.objects.filter(url__in=project_urls))  # .values_list('id', flat=True)

    projects = filter(lambda p: p.url not in existing, projects)
    print "len of projects before", len(projects)
    print "GoFundMe scraper - Bulk creating " + str(len(projects)) + " projects"
    logger.info("GoFundMe scraper - Bulk creating " + str(len(projects)) + " projects")

    projects = map(lambda p: Campaign(**p.to_dict()), projects)
    print "len of projects ", len(projects)
    Campaign.objects.bulk_create(projects)
    print "GoFundMe scraper - Bulk update"
    logger.info("GoFundMe scraper - Bulk update")

    for project in existing:
        project.goal = project_data_map[project.url].get('goal')
        project.last_updated = project_data_map[project.url].get('last_updated')
        project.goal = project_data_map[project.url].get('raised')

    bulk_update(existing)
    print "Saved " + str(len(existing)) + " latest almost funded projects from GoFundMe"
    logger.info("Saved " + str(len(existing)) + " latest almost funded projects from GoFundMe")

@periodic_task(
    run_every=(crontab(minute='*/15')),
    name="task_scrape_latest_crowdrise",
    ignore_result=True
)
def task_scrape_latest_crowdrise():
    """
    Saves latest almost funded projects from CrowdRise
    """
    # TODO: automate update of 'common' categories

    CATEGORIES = ['flint-water-crisis', 'medical', 'volunteer', 'emergencies', 'education', 'memorials', 'sports', 'animals', 'creative', 'community', 'charity']
    projects = []
    project_data_map = {}
    scraper = CrowdRiseScraper

    for category in CATEGORIES:
        print "CrowdRise processing category " + category
        logger.info("CrowdRise processing category " + category)
        new_projects = scraper.find_projects(category, paginate=True)
        projects += new_projects

    for p in projects:
        project_data_map[p.url] = p

    project_urls = set(project_data_map.keys())

    existing = list(Campaign.objects.filter(url__in=project_urls))  # .values_list('id', flat=True)

    projects = filter(lambda p: p.url not in existing, projects)

    print "CrowdRise scraper - Bulk creating " + str(len(projects)) + " projects"
    logger.info("CrowdRise scraper - Bulk creating " + str(len(projects)) + " projects")

    projects = map(lambda p: Campaign(**p.to_dict()), projects)
    Campaign.objects.bulk_create(projects)
    print "CrowdRise scraper - Bulk update"
    logger.info("CrowdRise scraper - Bulk update")

    for project in existing:
        project.goal = project_data_map[project.url].get('goal')
        project.last_updated = project_data_map[project.url].get('last_updated')
        project.goal = project_data_map[project.url].get('raised')

    bulk_update(existing)
    print "Saved " + str(len(existing)) + " latest almost funded projects from CrowdRise"
    logger.info("Saved " + str(len(existing)) + " latest almost funded projects from CrowdRise")