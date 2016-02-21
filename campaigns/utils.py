from campaigns.scrapers import KickstarterScraper

__author__ = 'lorenamesa'

def task_scrape_latest_kickstarter():
    scraper = KickstarterScraper
    scraper.find_projects('projects', 'cancer', )
