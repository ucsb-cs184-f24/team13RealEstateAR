import requests

from house_dataset_creator import HouseDatasetCreator

creator = HouseDatasetCreator('AIzaSyCOUyvZo0K1lobh_wMK4oqzwCaV8xzxKhk')

iphone_res = '3024x4032'
address = '6682 Trigo Rd, Goleta, CA 93117', '3080 Deseret Dr, El Sobrante, CA 94803'
radius = 200
output_dir = 'nearby_houses'
creator.fetch_images_houses_nearby(size=iphone_res, 
                                   address=address, 
                                   radius=radius, 
                                   output_dir=output_dir)
