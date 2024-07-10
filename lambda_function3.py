import json
import urllib3

http = urllib3.PoolManager()

def lambda_handler(event, context):


    url = "https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data"
    headers = {
        'X-Siemens-Auth' : 'test',
        'Content-Type' : 'application/json'
    }

    payload = {
        "subnet_id": event["subnet_id"],
        "name": event["Kaif Raza"],
        "email" : event["kaifraza8329@gmail.com"]
    }


    

    

    encoded_data = json.dumps(payload).encode('utf-8')


    
    response = http.request.('POST',url,body=encoded_data,headers=headers)
    

        return{
            'statusCode': response.status,
            'body' : response.data.decode('utf-8')
        }