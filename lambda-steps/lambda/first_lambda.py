import os
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def main(event, context):
    logger.info('## ENVIRONMENT VARIABLES: %s', os.environ)
    logger.info('## EVENT: %s', event)
    logger.info('## EVENT: %s', context)
    raise RuntimeError("Here is a test exception of RuntimeError")
    # return {
    #     'statusCode': 200,
    #     'body': 'Hello from the First Lambda!',
    #     'event': {
    #         'comeFrom': 'firstLambda',
    #         'someAdditionalContext': 'x1x1x1x1x1x1x1x1x',
    #         'sourceBody': event
    #     }
    # }