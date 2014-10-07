import re
import csv
from pprint import pprint
import operator
import requests
import json

def AddQuery(url, method, count, system, data = []):
    post_url = 'http://scuttle/queries'
    post_data = {
        'url':url,
        'method':method,
        'data':data,
    }
    headers = {'content-type': 'application/json'}
    cookies = {'system':'{}'.format(system)}
    # print requests.post(post_url, data=json.dumps(post_data), headers=headers, cookies=cookies).text

def FindMostUsedQueries(log_file, system, add_query = False):
    first_row = []
    raw_index = 0
    queries = {}

    with open(log_file, 'rU') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')

        count = 0
        for row in spamreader:
            s = ", ".join(row)
            m = re.search('(GET|POST|DELETE|PUT)\shttps?://pds[0-9A-Za-z\.-]*.debesys.net/api/1/?([0-9A-za-z]*/?)*\??([0-9A-za-z]*=[0-9A-za-z]*&?)*', s)
            if m:
                url = m.group(0)
                url_post = url.find('api/1') + 3
                url_meth = url.find(' http')

                new_url = url[url_post:len(url)] 
                url_method = url[0:url_meth]
                if not queries.has_key( new_url ):
                    queries[new_url] = {'count':0, 'method':url_method}
                queries[new_url]['count'] += 1

    q_counts = {}
    for q, v in queries.items():
        if v['count'] > 50:
            # print v['count'], ":", v['method'], q
            q_counts[q] = v['count']
            if v['method'] == 'GET':
                if add_query:
                    AddQuery(q, v['method'], system, [])

    q_counts = sorted(q_counts.items(), key=operator.itemgetter(1), reverse=True)
    for q in q_counts:
        print q[1], ":", q[0]

if __name__ == '__main__':
    FindMostUsedQueries( '/Users/cparks/Downloads/pds_log.csv', 1, True )
    FindMostUsedQueries( '/Users/cparks/Downloads/pds_log_dev.csv', 1 )
