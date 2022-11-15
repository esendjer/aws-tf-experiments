import os
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def main(event, context):
    logger.info('## ENVIRONMENT VARIABLES: %s', os.environ)
    logger.info('## EVENT: %s', event)
    logger.info('## EVENT: %s', context)
    return {
        'statusCode': 200,
        'body': 'Hello from the Second Lambda!',
        'sourceBody': event,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
    }