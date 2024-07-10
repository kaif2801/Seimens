import json
import urllib.request

def lambda_handler(event, context):
    payload = {
        "subnet_id": event['subnet_id'],
        "name": event['Kaif Raza'],
        "email" : event['kaifraza8329@gmail.com']
    }


    

    headers = {
        'X-Siemens-Auth' : 'test',
        'Content-Type' : 'application/json'
    }

    data = json.dumps(payload).encode('utf-8')

    req = urllib.request.Request('https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data',data=data, headers=headres)
    response = urllib.request.urlopen(req)
    result = response.read().decode('utf-8')

        return{
            'statusCode': 200,
            'body' : json.loads(result)
        }