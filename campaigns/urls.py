from django.conf.urls import url

from views import scrape_kickstarter, latest_kickstarter, example, latest, latest_gofundme, index

urlpatterns = [
    url(r'^example/', index, name='index'),
    url(r'^latest/', latest, name='latest'),
    url(r'^kickstarter/latest', latest_kickstarter, name='latest_kickstarter'),
    url(r'^kickstarter/', scrape_kickstarter, name='scrape_kickstarter'),
    url(r'^gofundme/latest', latest_gofundme, name='latest_gofundme'),
    # url(r'^gofundme/', scrape_gofundme, name='scrape_gofundme')
]
