import requests
import json
import base64

def login(username, password="12345678"):

    access_token = None
    clientId ='7acb772129644c4483f9944eec85476f'
    clientSecret ='417b19d133024e1e85e13133077cf7362de80f0f32e44a338383f0f7d0140f78'
    encodeValue = base64.b64encode('{0}:{1}'.format(clientId, clientSecret))

    loginUrl ='https://id.ttstage.com/oauth/token'
    loginPayload = {'grant_type': 'password', 'username': username, 'password': password}
    loginHeaders = {'Connection': 'keep-alive', 'Authorization': 'Basic {0}'.format(encodeValue), 'Content-Type': 'application/x-www-form-urlencoded'}

    print ("Login to: %s" % loginUrl)

    print encodeValue
    rLogin = requests.post(url=loginUrl, data=loginPayload, headers=loginHeaders)

    if rLogin.ok:
        access_token = json.loads(rLogin.content)['access_token']
        access_token = "Bearer " + access_token
    else:
        print ('Failed login.  Status code: {0} {1}'.format(rLogin.status_code, rLogin.content))

    return access_token

if __name__ == "__main__":
    print login('robert.spiegel@tradingtechnologies.com', 'Tt12345678')
