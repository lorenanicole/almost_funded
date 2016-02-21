import re
import urllib
import requests
import json
from bs4 import BeautifulSoup


class KickstarterScraper(object):
    # TODO: get list of all categories from projects for rendering possible list on main view
    base_url = "https://www.kickstarter.com"
    projects_query_path = "/projects/search.json?search=projects&term={0}"
    discover_query_path = "/discover/advanced.json?search=projects&term={0}"

    @classmethod
    def find_projects(cls, query, paginate=False):
        query = urllib.quote_plus(query)
        request_url = cls.base_url + cls.discover_query_path.format(query)
        response = requests.get(request_url).content
        content = json.loads(response)

        if paginate:

            reasonable_limit = 40

            next_page = 2
            request_url = cls.base_url + cls.discover_query_path.format(query) + "&page={0}".format(next_page)
            response = requests.get(request_url).content
            content = json.loads(response)



        return content


class GiveForwardScraper(object):
    base_url = "http://www.giveforward.com"
    fundraiser_query_path = "/fundraisers?query={0}"
    # expanded_fundraiser_query = "/fundraisers?authenticity_token={0}&page={1}&search%5B" \
    #                             "filters%5D%5BClose%20To%20Goal%5D=1&search%5Bpage%5D={2}&" \
    #                             "search%5Bper_page%5D=30&search%5Bterm%5D={3}&utf8=%E2%9C%93"

    @classmethod
    def find_projects(cls, query, paginate=False):
        query = urllib.quote_plus(query)
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query))
        html = BeautifulSoup(response.content)
        # button = html.find('input', {'id': 'search_filters_Close To Goal'})

        projects = html.find_all('div', class_='fr-card-search')
        almost_funded = []

        if paginate:

            next_page_path = filter(lambda path: 'Next' in path.get_text(), html.find('nav', class_='pagination').find_all('a'))

            if next_page_path:
                # TODO: Why doesn't it work to crawl to successive pages? There's a CSRF token (it's a Rails App), investigate?

                next_page_path = next_page_path[0].get('href')
                current_page = int(re.findall('\d', next_page_path)[0])

            reasonable_limit = 10

            # while next_page_path and reasonable_limit >= 1:
            #     response = requests.get(cls.base_url + next_page_path)
            #     html = BeautifulSoup(response.content)
            #     # content csrf-token
            #     new_projects = html.find_all('div', class_='fr-card-search')
            #     projects += new_projects
            #
            #     csrf_token = filter(lambda meta: meta.get('name') == 'csrf-token', html.find_all('meta'))
            #
            #     if csrf_token:
            #         # current_page = int(re.findall('\d', next_page_path)[0])
            #         next_page_path = cls.meh.format(csrf_token[0].get('content'), current_page + 1, query) #cls.expanded_fundraiser_query.format(csrf_token[0].get('content'), current_page + 1, current_page, query)
            #
            #     print next_page_path
            #     current_page += 1
            #     reasonable_limit -= 1

        for project in projects:
            percent_raised = float(project.find('span', class_='meter').get('style').strip('width:').strip('%'))
            print "percent raised: ", percent_raised
            if 90.0 < percent_raised < 100.0:
                almost_funded.append(project)

        return almost_funded

class GoFundMeScraper(object):
    base_url = "https://www.gofundme.com"
    fundraiser_query_path = "/mvc.php?route=search&term={0}"
    almost_there_path = "/mvc.php?route=index/hometoggle&toggle=almostthere"

    @classmethod
    def find_projects(cls, query, paginate=False):
        query = urllib.quote_plus(query)
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query))
        html = BeautifulSoup(response.content)
        projects = html.find_all('div', class_='search_tile')

        if paginate:

            next_page_path = filter(lambda path: path.get_text() == 'Next', html.find_all('a', class_='box'))

            if next_page_path:
                next_page_path = next_page_path[0].get('href')

            num_projects = html.find('div', class_='numbers').get_text()

            if 'thousands' in num_projects:
                reasonable_limit = 20
            else:
                reasonable_limit = 40

            while next_page_path and reasonable_limit >= 1:
                response = requests.get(cls.base_url + next_page_path)
                html = BeautifulSoup(response.content)
                new_projects = html.find_all('div', class_='search_tile')
                projects += new_projects

                next_page_path = filter(lambda path: path.get_text() == 'Next', html.find_all('a', class_='box'))

                if next_page_path:
                    next_page_path = next_page_path[0].get('href')

                reasonable_limit -= 1

        almost_funded = []

        for project in projects:
            percent_raised = int(project.find('span', class_='fill').get('style').strip('width: ').strip('%;'))

            if 90.0 < percent_raised < 100.0:
                almost_funded.append(project)

        return almost_funded

class CrowdRiseScraper(object):
    base_url = "https://www.crowdrise.com"
    fundraiser_query_path = "/search/project-results/{0}/{1}/{2}"

    @classmethod
    def find_projects(cls, query, paginate=False):
        query = urllib.quote_plus(query)
        response = requests.get(cls.base_url + cls.fundraiser_query_path.format(query, query, query))
        html = BeautifulSoup(response.content)
        projects = html.find_all('div', class_='content clearfix ')

        if paginate:

            other_project_paths = html.find_all('a', class_='page_link')
            next_page_url = filter(lambda path: path.get_text() == 'Next >', other_project_paths)

            if next_page_url:
                next_page_url = next_page_url[0].get('href')

            reasonable_limit = 40

            while next_page_url and reasonable_limit >= 1:
                response = requests.get(next_page_url)
                html = BeautifulSoup(response.content)
                new_projects = html.find_all('div', class_='content clearfix ')  # TODO: This is still buggy fix meeeee
                projects += new_projects

                other_project_paths = html.find_all('a', class_='page_link')
                other_project_paths = filter(lambda path: path.get_text() == 'Next >', other_project_paths)

                if other_project_paths:
                    next_page_url = other_project_paths[0].get('href')

                else:
                    next_page_url = []

                reasonable_limit -= 1

        almost_funded = []

        for project in projects:
            description = project.find('div', class_='searchResultsStory').get_text()

            budget_items = list(re.findall('\$\d{1,}', description))
            budget_items = map(lambda item: int(item.strip('$')), budget_items)

            try:
                percent_raised = budget_items[0] / float(budget_items[1])

                if 0.90 < percent_raised < 1.0:
                    almost_funded.append(project)
            except ZeroDivisionError as e:
                percent_raised = 0.0

        return almost_funded


if __name__ == '__main__':
    scraper = KickstarterScraper
    projects = scraper.find_projects('project', 'cancer', )

    for project in projects:
        print project

    # scraper = CrowdRiseScraper
    # print scraper.find_projects('cancer', paginate=True)

    # scraper = GiveForwardScraper
    # campaigns = scraper.find_projects('cancer', paginate=True)
    # for campaign in campaigns:
    #     print float(campaign.find('span', class_='meter').get('style').strip('width:').strip('%'))

    # scraper = GoFundMeScraper
    # projects = scraper.find_projects('cancer', True)
    #
    # for project in projects:
    #     print "{0} percent raised".format(int(project.find('span', class_='fill').get('style').strip('width: ').strip('%;')))