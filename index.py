import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')
lambda_client = boto3.client('lambda')

def parse_content(data):
    data=data.replace("00", " ")
    data=''.join([i for i in data if not i.isdigit()])
    return data

def invoke_notification_lambda(content):
    notification_lambda = 'daniel-interview-lambda-nice-devops-interview-notifications'
    input_text = 'SUCCESS'
    recipient_email = 'danielb630@gmail.com'
    payload = {
        'input_text': input_text,
        'recipient_email': recipient_email,
        'converted_text_file': content
    }
    try:
        response = lambda_client.invoke(
            FunctionName=notification_lambda,
            InvocationType='Event',  
            Payload=json.dumps(payload)
        )
        logger.info(f"Lambda {notification_lambda} invoked successfully")
        return True

    except Exception as e:
        logger.error(f"Error invoking Lambda function: {e}")
        return False


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    try:
        response = s3_client.get_object(Bucket=bucket, Key=key)
        content = response['Body'].read().decode('utf-8')
        conv_content=parse_content(content)
        invoke_notification_lambda(conv_content)
        return {
            'statusCode': 200,
            'body': json.dumps('Lambda invoked successfully!')
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error reading file: {str(e)}')
        }
