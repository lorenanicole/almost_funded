from django.conf.urls import url

from views import scrape_kickstarter, latest_kickstarter, example, latest, latest_gofundme, latest_crowdrise, \
    latest_giveforward, scrape_gofundme

urlpatterns = [
    url(r'^example/', example, name='example'),
    url(r'^latest/', latest, name='latest'),
    url(r'^kickstarter/latest', latest_kickstarter, name='latest_kickstarter'),
    url(r'^kickstarter/', scrape_kickstarter, name='scrape_kickstarter'),
    url(r'^gofundme/latest', latest_gofundme, name='latest_gofundme'),
    url(r'^gofundme/', scrape_gofundme, name='scrape_gofundme'),
    url(r'^crowdrise/latest', latest_crowdrise, name='latest_crowdrise'),
    url(r'^giveforward/latest', latest_giveforward, name='latest_giveforward'),
    # url(r'^gofundme/', scrape_gofundme, name='scrape_gofundme')
]
