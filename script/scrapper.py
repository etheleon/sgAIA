#!/usr/bin/env python

import re,csv,time,os,unicodedata
from urllib2 import urlopen 
from bs4 import BeautifulSoup

#fieldnames = ['Fund Name', 'Currency', 'Offer Price', 'Bid Price', 'Valuation Date', 'Price Status']

#Output
if not os.path.exists('./funds'):
    os.makedirs('./funds')
#TSV file
if not os.path.exists('./funds/details'):
    os.makedirs('./funds/details')

path = 'funds/details/table.tsv'


#Reading website
summarypage = 'http://www.aia.com.sg/FundPrices_New.aspx?Area=AIA'
content = urlopen(summarypage).read()
soup = BeautifulSoup(content)

with open(path, "a") as output_file:
    csv_writer = csv.writer(output_file)
    table = soup.find('table', id='dgFund')
#print table
    for innertable in table.findAll('table',{"class":"td"}):
    	rowdata = []
    	for fund in innertable.findAll('a', href=True):
    	    rowdata.append(fund.text)
    	cols = innertable.findAll('td')
    	rowdata = [re.sub(r"\s+$", "", elem.text.encode('utf-8')).replace('\xc2\xa0', '') for elem in cols]
    	csv_writer.writerow(rowdata)
