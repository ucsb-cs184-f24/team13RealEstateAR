import http.client
import os
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
# attomid (property ID)
attomid = "156379932"

endpoint = f"/propertyapi/v1.0.0/property/detailowner?attomid={attomid}"

# API request for the property details with owner information
conn.request("GET", endpoint, headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))