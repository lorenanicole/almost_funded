from types import NoneType
import requests
import json
from bs4 import BeautifulSoup


class KickstarterScraper(object):
    # TODO: get list of all categories from projects for rendering possible list on main view


    base_url = "https://www.kickstarter.com"
    projects_query_path = "/projects/search.json?search={0}&term={1}"

    @classmethod
    def scrape_projects(cls, search, term):
        request_url = cls.base_url + cls.projects_query_path.format(search, term)
        response = requests.get(request_url).content
        content = json.loads(response)
        for item in content:
            print content

        return content


class GiveForwardScraper(object):
    base_url = "http://www.giveforward.com"
    fundraiser_query_path = "/fundraisers?query={0}"

    @classmethod
    def find_projects(cls, query):
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query))
        html = BeautifulSoup(response.content)
        # button = html.find('input', {'id': 'search_filters_Close To Goal'})

        projects = html.find_all('div', class_='fr-card-search')
        almost_funded = []

        for project in projects:
            percent_raised = float(project.find('span', class_='meter').get('style').strip('width:').strip('%'))
            if 90.0 < percent_raised < 100.0:
                almost_funded.append(project)

        return almost_funded

class GoFundMeScraper(object):
    base_url = "https://www.gofundme.com"
    fundraiser_query_path = "/mvc.php?route=search&term={0}"
    almost_there_path = "/mvc.php?route=index/hometoggle&toggle=almostthere"

    @classmethod
    def find_projects(cls, query, paginate=False):
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query))
        html = BeautifulSoup(response.content)
        projects = html.find_all('div', class_='search_tile')

        if paginate:

            try:
                next_page_path = html.find('a', class_='box').get('href')
                num_projects = html.find('div', class_='numbers').get_text()
                more_projects = True
            except AttributeError as e:
                more_projects = False
                num_projects = ''



            if 'thousands' in num_projects:
                reasonable_limit = 20
            else:
                reasonable_limit = 40

            while more_projects and reasonable_limit >= 0:
                response = requests.get(cls.base_url + next_page_path)
                html = BeautifulSoup(response.content)
                new_projects = html.find_all('div', class_='search_tile')
                projects += new_projects

                try:
                    next_page_path = html.find('a', class_='box').get('href')
                    num_projects = html.find('div', class_='numbers').get_text()
                    more_projects = True
                except AttributeError as e:
                    more_projects = False

                reasonable_limit -= 1
                print reasonable_limit, len(projects)

        almost_funded = []

        for project in projects:
            percent_raised = int(project.find('span', class_='fill').get('style').strip('width: ').strip('%;'))
            print percent_raised
            if 90.0 < percent_raised < 100.0:
                almost_funded.append(project)

        return almost_funded



if __name__ == '__main__':
    # scraper = GiveForwardScraper
    # campaigns = scraper.find_projects('cancer')
    # for campaign in campaigns:
    #     print float(campaign.find('span', class_='meter').get('style').strip('width:').strip('%'))

    # scraper = GoFundMeScraper
    # projects = scraper.find_projects('cancer', True)
    #
    # for project in projects:
    #     print "{0} percent raised".format(int(project.find('span', class_='fill').get('style').strip('width: ').strip('%;')))