from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
from scrapers import KickstarterScraper


def example(request):
    return HttpResponse(content="Hello world", status=200)

def scrape_kickstarter(request):
    scraper = KickstarterScraper
    projects = scraper.find_projects("projects", "latino", )
    return HttpResponse(content=projects, status=200)