from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from campaigns.models import Campaign
from scrapers import KickstarterScraper, GoFundMeScraper

COLORS = ['orange', 'purple', 'green', 'blue', 'red']

def example(request):
    scraper = KickstarterScraper
    projects = scraper.find_projects('cancer', paginate=True)
    projects = map(lambda p: Campaign(**p.to_dict()), projects)
    return HttpResponse(content="Hello world", status=200)

def scrape_kickstarter(request):
    scraper = KickstarterScraper
    projects = scraper.find_projects("projects", paginate=True)

    if projects:
        campaigns = map(lambda p: Campaign(**p.to_dict()), projects)
        Campaign.objects.bulk_create(campaigns)

    projects = map(lambda p: p.to_dict(), projects)
    for p in projects:
        p['category'] = str(p.get('category'))

    return JsonResponse({'projects': [p.to_dict() for p in projects]}, status=200)

def scrape_gofundme(request):
    scraper = GoFundMeScraper
    projects = scraper.find_projects("projects", paginate=True)

    if projects:
        campaigns = map(lambda p: Campaign(**p.to_dict()), projects)
        Campaign.objects.bulk_create(campaigns)

    projects = map(lambda p: p.to_dict(), projects)
    for p in projects:
        p['category'] = str(p.get('category'))

    return JsonResponse({'projects': projects}, status=200)

def latest(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').reverse()[:count])

    for p in projects:
        if p.deadline:
            p.deadline = p.deadline.isoformat()

    return JsonResponse({'projects': projects}, status=200)


def latest_kickstarter(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=0).reverse()[:count])

    for p in projects:
        p.deadline = p.deadline.isoformat()

    return render(request, 'jinja2/tile.html', context={'projects': projects, 'title': 'Kickstarter', 'colors': COLORS}, status=200, using='jinja2')

def latest_gofundme(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=1).reverse()[:count])
    return render(request, 'jinja2/tile.html', context={'projects': projects, 'title': 'GoFundMe', 'colors': COLORS}, status=200, using='jinja2')

def latest_crowdrise(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=2).reverse()[:count])

    return render(request, 'jinja2/tile.html', context={'projects': projects, 'title': 'CrowdRise', 'colors': COLORS}, status=200, using='jinja2')

def latest_giveforward(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=3).reverse()[:count])

    for p in projects:
        p['deadline'] = p['deadline'].isoformat()

    return render(request, 'jinja2/tile.html', context={'projects': projects, 'title': 'GiveForward', 'colors': COLORS}, status=200, using='jinja2')