# RealEstateAR
This is a AR-Enhanced Smart Property Information Explorer.

## Team Members: (Alphabetical Order) ##
| Name             | Github ID           |
| ---------------- | ------------------- |
| Angel Gutierrez  | AngelG261           |
| Animesh Sachan   | theanimated01       |
| Christopher Riney| CJRiney             |
| Lixing(Leo) Guo  | HououinKyouma-2036  |
| Vedant Shah      | vedantshah99        |
| Zephyr Zhou    	 | zephyrz73           |


## Descriptions: ##
**Tech Stack**: 
- IOS platform
- `Language`: Swift, Python
- SwiftUI for the frontend
- Swift for backend
- Firebase for database


**Paragraph Description**:
The app is geared towards potential home buyers where the user can get instant details about a house that they’re interested in buying. Upon opening the app, the user points the camera towards the house of interest, the app then gets the user's coordinates (using Core Location) which we use to get an image of the house using Google Map's static street view API. It then uses a model to compare the user image and the Google image to ensure that the correct listing details are displayed. Some of the information that will be displayed via AR includes the listing price, number of bedrooms and bathrooms, and the owners. 

## User Roles ##
- House Hunters: People looking for information on houses to buy in a neighborhood; our app will provide them a way to see the prices of a house that they point their phone at & enable them to make markings
- Market Researcher: Researcher who wants to know the price and mortgage information about properties for market research like trending & prediction; our app can provide the the detailed multi-dimensional property information to them
- House Seller: People who want to sell houses want to know the average property price around the area; our app enable them to get the information they want quickly

## APIs ##
* ATTOM API: property information
* Google Map API: geographical information and street views for computer vision models
