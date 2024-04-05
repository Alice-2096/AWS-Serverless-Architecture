import boto3
import uuid
import json 
import os

table_name = os.getenv("table_name")
region_= os.getenv("region")
dynamodb = boto3.resource("dynamodb", region_name=region_)
table = dynamodb.Table(table_name)
    
def lambda_handler(event, context):
    hex_string = uuid.uuid4().hex
    new_id = int(hex_string, 16) % (10 ** 38)
    error_message = {
        'statusCode': 400,
        'headers': {'Content-Type': 'application/json'}, 
        'body': json.dumps({'message': 'Invalid request'})
    }
    
    # note: event is passed as a dict
    if 'body' not in event or event['body'] is None: 
        return error_message
    
    if 'email' not in event['body']:
        return error_message
    
    request_body = json.loads(event['body']) # parse body as JSON object
        
    if 'email' not in request_body:
        return error_message
    
    email_ = request_body['email']
    table.put_item(Item={
        'id': new_id,
        'email': email_
    })

    return { 
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps({'id': new_id})
    }