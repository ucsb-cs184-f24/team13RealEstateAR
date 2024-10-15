import http.client
import os
import urllib.parse
from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv('API_KEY')

if not api_key:
    raise ValueError("API key is missing! Please add it to your .env file.")

conn = http.client.HTTPSConnection("api.gateway.attomdata.com")

headers = {
    'accept': "application/json",
    'apikey': api_key
}

# define the query parameters (address1, address2)
address1 = "6575 Trigo" # put specific street num here
address2 = "Goleta, CA" # city/town, state code

# required for URLs: encode the query parameters -> parse & converts spaces and special characters into percent-encoded format
encoded_address1 = urllib.parse.quote(address1)
encoded_address2 = urllib.parse.quote(address2)

endpoint = f"/propertyapi/v1.0.0/property/basicprofile?address1={encoded_address1}&address2={encoded_address2}"

# make the API request for basic property information
conn.request("GET", endpoint, headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))