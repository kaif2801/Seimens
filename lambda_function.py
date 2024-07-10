import json
import urllib.request

def lambda_handler(event, context):
    payload = {
        "subnet_id": event['subnet_id'],
        "name": event['Kaif Raza'],
        "email" : event['kaifraza8329@gmail.com']
    }


    url = 'https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data'

    headers = {
        'X-Siemens-Auth' : 'test',
        'Content-Type' : 'application/json'
    }

    data = json.dumps(payload).encode('utf-8')

    req = urllib.request.Request(url,data=data, headers=headers, method='POST')


    try:
        with urllib.request.urlopen(req) as response:
            response_data = response.read().decode('utf-8')
            print(response_data)


            return{
                'statusCode' : 200,
                'body' : response_data
            }

    except Exception as e:
        print(f"Error: {str(e)}")

        return {
            'statusCode' : 200,
            'body' : json.dumps({'error': str(e)})

        }