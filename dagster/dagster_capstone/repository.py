"""repository.py
    Not sure if I fully understand this file.  I think it just groups jobs, schedules, steps into a repository,
    so you can call it inside of dagit.  The documentation is not that clear. 

    Reference: https://docs.dagster.io/concepts/repositories-workspaces/repositories#repositories

"""
from dagster import repository
from dagster_capstone.hello_world import diamond
from dagster_capstone.graphs.say_hello import say_hello_job
from dagster_capstone.schedules.my_hourly_schedule import my_hourly_schedule
from dagster_capstone.sensors.my_sensor import my_sensor

@repository
def dagster_capstone():
    """
    The repository definition for this dagster_capstone Dagster repository.

    For hints on building your Dagster repository, see our documentation overview on Repositories:
    https://docs.dagster.io/overview/repositories-workspaces/repositories
    """
    jobs = [say_hello_job, diamond]
    schedules = [my_hourly_schedule]
    sensors = [my_sensor]

    return jobs + schedules + sensors
