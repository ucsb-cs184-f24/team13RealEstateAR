import requests

def fetch_static_map_image(latitude, longitude, heading, api_key, file_name):
    url = f"https://maps.googleapis.com/maps/api/streetview?size=600x400&location={latitude},{longitude}&heading={heading}&key={api_key}"
    
    # Make the request to the Google Maps Static API
    response = requests.get(url)
    if response.status_code == 200:
        with open(file_name, 'wb') as file:
            file.write(response.content)
        print(f"Map image saved as {file_name}")
    else:
        print(f"Failed to fetch image. Status code: {response.status_code}")

if __name__ == "__main__":
    api_key = "AIzaSyD-BaS2R7PIqBI_tHpa0Uc3AGxjcQnuESU"
    latitude = 0
    longitude = 0 
    heading = 0
    num = 1
    file_name = f"map_image{num}.jpg"
    
    fetch_static_map_image(latitude, longitude, heading, api_key, file_name)