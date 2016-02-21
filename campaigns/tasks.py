from __future__ import absolute_import

from celery.task.schedules import crontab
from celery.decorators import periodic_task
from celery.utils.log import get_task_logger

from campaigns.utils import task_scrape_latest_kickstarter

__author__ = 'lorenamesa'

logger = get_task_logger(__name__)


@periodic_task(
    run_every=(crontab(minute='*/15')),
    name="task_scrape_latest_kickstarter",
    ignore_result=True
)
def task_scrape_latest_kickstarter():
    """
    Saves latest almost funded projects from Kickstarter
    """
    task_scrape_latest_kickstarter()
    logger.info("Saved latest almost funded projects from Kickstarter")

