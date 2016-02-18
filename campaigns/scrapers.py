import requests
import json
from bs4 import BeautifulSoup


class KickstarterScraper(object):
    # TODO: get list of all categories from projects for rendering possible list on main view


    base_url = "https://www.kickstarter.com/"
    projects_query_path = "projects/search.json?search={0}&term={1}"

    @classmethod
    def scrape_projects(cls, search, term):
        request_url = cls.base_url + cls.projects_query_path.format(search, term)
        response = requests.get(request_url).content
        content = json.loads(response)
        for item in content:
            print content

        return content


class GiveForwardScraper(object):
    base_url = "http://www.giveforward.com/"
    fundraiser_query_path = "fundraisers?query={0}"

    @classmethod
    def find_projects(cls, query):
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query))
        html = BeautifulSoup(response.content)
        # button = html.find('input', {'id': 'search_filters_Close To Goal'})

        campaigns = html.find_all('div', class_='fr-card-search')
        almost_funded = []

        for indx, campaign in enumerate(campaigns):
            percent_raised = float(campaign.find('span', class_='meter').get('style').strip('width:').strip('%'))
            if percent_raised > 90.0 and percent_raised != 100.0:
                almost_funded.append(campaign)

        return almost_funded


# if __name__ == '__main__':
#     scraper = GiveForwardScraper
#     campaigns = scraper.find_projects('cancer')
#     for campaign in campaigns:
#         print float(campaign.find('span', class_='meter').get('style').strip('width:').strip('%'))
