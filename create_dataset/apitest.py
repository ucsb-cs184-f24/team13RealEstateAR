import requests

def download_street_view_image(lat, lon, heading, pitch, api_key, filename):
    base_url = "https://maps.googleapis.com/maps/api/streetview"
    params = {
        'size': '600x400',  # Image size
        'location': f'{lat},{lon}',  # Latitude and longitude
        'heading': heading,  # Camera direction (0-360)
        'pitch': pitch,  # Camera vertical angle (-90 to 90)
        'key': api_key  # Google API Key
    }
    
    response = requests.get(base_url, params=params)
    
    if response.status_code == 200:
        with open(filename, 'wb') as file:
            file.write(response.content)
        print(f"Image saved as {filename}")
    else:
        print(f"Error fetching image: {response.status_code}, {response.text}")

def get_images_of_house(lat, lon, api_key):
    headings = [0, 90, 180, 270]  # Different angles (north, east, south, west)
    pitch = 0  # Horizontal angle (adjust if you want up or down views)
    
    for idx, heading in enumerate(headings):
        filename = f"./house_view_{heading}.jpg"
        download_street_view_image(lat, lon, heading, pitch, api_key, filename)

# Example usage
api_key = 'AIzaSyCOUyvZo0K1lobh_wMK4oqzwCaV8xzxKhk'
latitude = 34.052235  # Example latitude (replace with actual house coordinates)
longitude = -118.243683  # Example longitude (replace with actual house coordinates)

get_images_of_house(latitude, longitude, api_key)
