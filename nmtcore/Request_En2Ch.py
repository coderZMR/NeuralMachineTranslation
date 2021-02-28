# *-* coding: utf-8 *-*
import json
import base64
import argparse
import sys
import requests

def translate(sent):
    payload = {'sent':sent}
    r = requests.get("http://localhost:8842/translate/api_translate", data=payload)
    for i in json.loads(r.text)['translates']:
        print(i)
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('sent',type=str,help='sentence to be translated')
    args = parser.parse_args(sys.argv[1:])
    translate(args.sent)