from django.conf.urls import url

from views import *

urlpatterns = [
	# ex: /polls/
	# url(r'^$', views.index, name='index'),
    url(r'^example/', example, name='example'),
    url(r'^kickstarter/', scrape_kickstarter, name='scrape_kickstarter')

]
