import http.client
import os
from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv('API_KEY')

if not api_key:
    raise ValueError("API key is missing. Please add it to your .env file.")

conn = http.client.HTTPSConnection("api.gateway.attomdata.com")

headers = {
    'accept': "application/json",
    'apikey': api_key
}

# define the query parameters (postalcode, page, pagesize)
postal_code = "93117" 
page = 1
page_size = 100

# make the API request for the property address
endpoint = f"/propertyapi/v1.0.0/property/address?postalcode={postal_code}&page={page}&pagesize={page_size}"
conn.request("GET", endpoint, headers=headers)

res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))