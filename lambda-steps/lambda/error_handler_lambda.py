import os

def main(event, context):
    '''
    event = {
        'ExecutionName': str,
        'Input': dict,
        'ExecutionStartTime': str,
        'Payload': str
    }
    '''
    return {
        'statusCode': 200,
        'body': 'Error Handler',
        'event': event,
    }