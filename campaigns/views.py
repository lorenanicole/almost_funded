from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from campaigns.models import Campaign
from scrapers import KickstarterScraper, GoFundMeScraper


def index(request):
    return render(request, 'example.html', context={'hi':'world'}, status=200)

def example(request):
    return HttpResponse(content="Hello world", status=200)

def scrape_kickstarter(request):
    scraper = KickstarterScraper
    projects = scraper.find_projects("projects", paginate=True)
    projects = map(lambda p: Campaign(**p.__dict__), projects)
    Campaign.objects.bulk_create(projects)
    return JsonResponse({'projects': projects}, status=200)

def scrape_gofundme(request):
    scraper = GoFundMeScraper
    projects = scraper.find_projects("projects", paginate=True)
    projects = map(lambda p: Campaign(**p.__dict__), projects)
    Campaign.objects.bulk_create(projects)
    return JsonResponse({'projects': projects}, status=200)

def latest(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').values('id', 'name', 'url', 'goal', 'raised', 'deadline', 'description', 'category').reverse()[:count])

    for p in projects:
        p['deadline'] = p['deadline'].isoformat()

    return JsonResponse({'projects': projects}, status=200)


def latest_kickstarter(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=0).values('id', 'name', 'url', 'goal', 'raised', 'deadline', 'description', 'category').reverse()[:count])

    for p in projects:
        p['deadline'] = p['deadline'].isoformat()

    # return JsonResponse({'projects': projects}, status=200)
    # from django.template.loader import get_template
    # template = get_template('jinja2/index.html')
    return render(request, 'jinja2/index.html', context={'projects': projects, 'title': 'Kickstarter', 'colors': ['orange', 'purple', 'green', 'blue', 'red']}, status=200, using='jinja2')

def latest_gofundme(request):
    count = request.GET.get('count')

    if not count:
        count = 50

    projects = list(Campaign.objects.order_by('last_updated').filter(source=1).values('id', 'name', 'url', 'goal', 'raised', 'deadline', 'description', 'category').reverse()[:count])

    for p in projects:
        p['deadline'] = p['deadline'].isoformat()

    return JsonResponse({'projects': projects}, status=200)