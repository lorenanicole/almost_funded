from campaigns.models import Campaign
from campaigns.scrapers import KickstarterScraper
from datetime import datetime

__author__ = 'lorenamesa'

def task_scrape_latest_kickstarter():
    KICKSTARTER_CATEGORIES = ['Art', 'Comics', 'Crafts', 'Dance', 'Design', 'Fashion', 'Film & Video', 'Food', 'Games', 'Journalism', 'Music', 'Photography', 'Publishing', 'Technology', 'Theater']
    projects = []
    scraper = KickstarterScraper

    last_updated = datetime.utcnow()

    for category in KICKSTARTER_CATEGORIES:
        projects += scraper.find_projects(category, paginate=True)

    for project in projects:
        projects = map(lambda p: {'name': p.get('name'),
                                    'deadline': p.get('deadline'),
                                    'goal': p.get('goal'),
                                    'raised': p.get('pledged'),
                                    'url': p.get('urls').get('web').get('project'),
                                    'description': p.get('blurb'),
                                    'last_updated': last_updated,
                                    'recipient': p.get('location').get('urls').get('location'),
                                    'creator': p.get('creator').get('name'),
                                    'location': p.get('location').get('short_name'),
                                    'category': p.get('category').get('slug')}, projects)

    Campaign.objects.bulk_create(projects)