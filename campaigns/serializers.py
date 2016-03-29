from datetime import datetime
from json import JSONEncoder
import re
from campaigns.models import Category

__author__ = 'lorenamesa'

class BaseProjectSerializer(object):
    def __init__(self, data, category, last_updated):
        self.data = data
        self.name = self.set_name()
        self.deadline = self.set_deadline()
        self.goal = self.set_goal()
        self.deadline = self.set_deadline()
        self.raised = self.set_raised()
        self.url = self.set_url()
        self.description = self.set_description()
        self.last_updated = last_updated
        self.recipient = self.set_recipient()
        self.creator = self.set_creator()
        self.location = self.set_location()
        self.category = Category.objects.get_or_create(category=category)[0]
        self.source = self.set_source()

    def __str__(self):
        return "{0} campaign {1} - {2} - has raised {3} of {4}.".format(self.__class__, self.name, self.url, self.raised, self.goal)

    def to_dict(self):
        return {
                    'name': self.name,
                    'deadline': self.deadline,
                    'goal': self.goal,
                    'raised': self.raised,
                    'url': self.url,
                    'description': self.description,
                    'last_updated': self.last_updated,
                    'recipient': self.recipient,
                    'creator': self.creator,
                    'location': self.location,
                    'category': self.category,
                    'source': self.source
                }


class KickstarterSerializer(BaseProjectSerializer):
    def set_name(self):
        return self.data.get('name')

    def set_deadline(self):
        return datetime.utcfromtimestamp(self.data.get('deadline'))

    def set_goal(self):
        return self.data.get('goal')

    def set_raised(self):
        return self.data.get('pledged')

    def set_url(self):
        return self.data.get('urls', {}).get('web', {}).get('project', 'N/A')

    def set_description(self):
        return self.data.get('blurb')

    def set_recipient(self):
        return self.data.get('location', {}).get('urls', {}).get('web', {}).get('location', 'N/A')

    def set_creator(self):
        return self.data.get('creator', {}).get('name', 'N/A')

    def set_location(self):
         return self.data.get('location', {}).get('short_name', 'N/A')

    def set_source(self):
        return 0

class CrowdRiseSerializer(BaseProjectSerializer):

    def set_name(self):
        return self.data.find('div', class_='searchResultsStory').find('a').get_text()

    def set_deadline(self):
        return None

    def set_goal(self):
        description = self.data.find('div', class_='searchResultsStory').get_text().replace(',','')
        return float(re.findall('Goal:\n\t{1,}\$\d{1,}', description)[0].strip('\n\tGoal:$ '))

    def set_raised(self):
        description = self.data.find('div', class_='searchResultsStory').get_text().replace(',','')
        return int(re.findall('Far:\n\t{1,}\$\d{1,}', description)[0].strip('\n\tFar:$ '))

    def set_url(self):
        return "https://www.crowdrise.com" + self.data.find('div', class_='profileLink').find('a').get('href')

    def set_description(self):
        return self.data.find('div', class_='searchResultsStory').get_text().replace(',','')

    def set_recipient(self):
        return None

    def set_creator(self):
        return self.data.find('div', class_='searchResultsStory').find('a').get_text()

    def set_location(self):
         return None

    def set_source(self):
        return 2

class GoFundMeSerializer(BaseProjectSerializer):

    def set_name(self):
        return self.data.find('div', class_='details').find('a', class_='title').get_text()

    def set_deadline(self):
        return None

    def set_goal(self):
        percent_raised = int(self.data.find('span', class_='fill').get('style').strip('width: ').strip('%;'))
        raised = self.data.find('div', class_='details').find('a', class_='amt').get_text().encode('utf-8')
        raised = list(re.findall('\$\d{1,}', raised))[0].strip('$')
        return int(percent_raised * int(raised))

    def set_raised(self):
        raised = self.data.find('div', class_='details').find('a', class_='amt').get_text().encode('utf-8')
        return list(re.findall('\$\d{1,}', raised))[0].strip('$')

    def set_url(self):
        return "http:" + self.data.find('div', class_='details').find('a', class_='title').get('href', 'N/A')

    def set_description(self):
        return None

    def set_recipient(self):
        return self.data.get('location', {}).get('urls', {}).get('web', {}).get('location', 'N/A')

    def set_creator(self):
        return self.data.find('div', class_='details').find('a', class_='name').get_text().strip('by ')

    def set_location(self):
         return self.data.find('div', class_='details').find('a', class_='extra').get_text()

    def set_source(self):
        return 1

class ProjectSerializer(object):
    TYPES = {'crowdrise': CrowdRiseSerializer,
             'kickstarter': KickstarterSerializer,
             'gofundme': GoFundMeSerializer}

    @staticmethod
    def factory(type, data, category, last_updated):
        return ProjectSerializer.TYPES.get(type)(data, category, last_updated)

