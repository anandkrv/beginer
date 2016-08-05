#!/usr/bin/python
import sys
import json
import requests

def add_ssh_key(KEY_NAME,PUBLIC_KEY,TOKEN,ENDPOINT):
        values = {"name" : KEY_NAME, "public_key": PUBLIC_KEY}
        headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' +TOKEN}
        url = ENDPOINT+"/account/keys"
        try:
                req = requests.post(url, headers=headers, data=json.dumps(values))
        except requests.exceptions.ConnectionError as e:
                print "Exception occured.."
                print "Exception: ",e
                sys.exit(1)
        req_content = req.content
        json_req = json.loads(req_content)
        SSH_ID = json_req.get('ssh_key').get('id')
        print SSH_ID

def launch_instance(SERVER_NAME,IMAGE,SIZE,ENDPOINT,TOKEN,REGION,SSH_ID):
        values = {"name" : SERVER_NAME, "region": REGION, "size": SIZE, "image": IMAGE, "ssh_keys": [SSH_ID]}
        headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' +TOKEN}
        url = ENDPOINT+"/droplets"
        try:
                req = requests.post(url, headers=headers, data=json.dumps(values))
        except requests.exceptions.ConnectionError as e:
                print "Exception occured.."
                print "Exception: ",e
                sys.exit(1)
        req_content = req.content
        json_req = json.loads(req_content)
        instance_id = json_req.get('droplet').get('id')
        print instance_id


def del_instance(ENDPOINT,TOKEN,instance_id):
        urldelete = ENDPOINT+"/droplets/"+instance_id
        print urldelete
        headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' +TOKEN}
        try:
                r = requests.delete(urldelete, headers=headers)
        except requests.exceptions.ConnectionError as e:
                print "Exception occured.."
                print "Exception: ",e
                sys.exit(1)

def get_server_ip(ENDPOINT,TOKEN,instance_id):
        headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' +TOKEN}
        url = ENDPOINT+"/droplets/"+instance_id
        try:
                req = requests.get(url, headers=headers)
        except requests.exceptions.ConnectionError as e:
                print "Exception occured.."
                print "Exception: ",e
                sys.exit(1)
        req_content = req.content
        json_req = json.loads(req_content)
        instance_ip = json_req.get('droplet').get('networks').get('v4')[0].get('ip_address')
        print instance_ip

eval(sys.argv[1])
