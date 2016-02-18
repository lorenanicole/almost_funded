import requests
import json


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
