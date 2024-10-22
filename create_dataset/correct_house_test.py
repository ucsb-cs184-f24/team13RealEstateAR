import requests
from house_dataset_creator import HouseDatasetCreator

creator = HouseDatasetCreator('AIzaSyCOUyvZo0K1lobh_wMK4oqzwCaV8xzxKhk')
iphone_res = '3024x4032'
addresses = [
    '6682 Trigo Rd, Goleta, CA 93117', 
    '3080 Deseret Dr, El Sobrante, CA 94803',
    '6645 Del Playa Dr, Goleta, CA 93117', 
    '6643 Del Playa Dr, Goleta, CA 93117',
    '7216 Fordham Pl, Goleta, CA 93117',
    '6649 Abrego Rd, Goleta, CA 93117, USA'
    ]

for addr in addresses:
    creator.fetch_house_image(address=addr, 
                              size=iphone_res,
                              output_path='./' + addr.replace(' ', '').replace(',', '') + '.jpg')
    