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



## APIs ##
* ATTOM API: property information
* Google Map API: geographical information and street views for computer vision models



**Paragraph Description**:
The app is geared towards potential home buyers where the user can get instant details about a house that they’re interested in buying. Upon opening the app, the user points the camera towards the house of interest, the app then gets the user's coordinates (using Core Location) which we use to get an image of the house using Google Map's static street view API. It then uses a model to compare the user image and the Google image to ensure that the correct listing details are displayed. Some of the information that will be displayed via AR includes the listing price, number of bedrooms and bathrooms, and the owners. 

## User Roles ##
- House Hunters: People looking for information on houses to buy in a neighborhood; our app will provide them a way to see the prices of a house that they point their phone at & enable them to make markings
- Market Researcher: Researcher who wants to know the price and mortgage information about properties for market research like trending & prediction; our app can provide the the detailed multi-dimensional property information to them
- House Seller: People who want to sell houses want to know the average property price around the area; our app enable them to get the information they want quickly

Here’s a structured outline of the roles and permissions for your app, considering the requirements and potential for user-contributed content:

## Permissions ##

#### 1. House Hunters

**Role Description:**  
Individuals seeking information about houses available for purchase in a neighborhood.

**Permissions:**
- **View Property Information:** Access to view prices and details of properties by pointing their phone at them.
- **Make Markings:** Ability to mark areas of interest on the map or property for personal notes.
- **Save Searches:** Option to save property searches for future reference.
- **Rate/Review Properties:** Option to rate and leave reviews for properties they visit.

**Goals:**
- To find suitable properties within their budget.
- To compare prices and features of different houses.

**How the App Helps:**
- The app provides real-time price data and property details through AR technology.
- Users can save and annotate their findings for easy reference later.

#### 2. Market Researcher

**Role Description:**  
Researchers looking to gather price and mortgage information for analysis and market predictions.

**Permissions:**
- **Access Detailed Property Data:** Ability to retrieve comprehensive property data, including prices, mortgage information, and trends.
- **Export Data:** Option to export property data in various formats (e.g., CSV, PDF) for analysis.
- **Analyze Trends:** Access to analytical tools within the app to study price trends over time.

**Goals:**
- To conduct market analysis for trending and prediction purposes.
- To gather reliable property data for research.

**How the App Helps:**
- The app provides multi-dimensional property information, allowing researchers to conduct in-depth analysis.
- Data visualization tools to see trends and patterns clearly.

#### 3. House Seller

**Role Description:**  
Individuals looking to sell their houses and needing information about property prices in their area.

**Permissions:**
- **View Average Property Prices:** Access to view average property prices in their neighborhood.
- **Market Comparison Tool:** Use a tool to compare their property against similar properties in the area.
- **Post Listings:** Ability to list their property for sale and manage their listings.
- **Receive Notifications:** Get alerts on market changes or price adjustments in their area.

**Goals:**
- To determine a competitive price for their property.
- To quickly gather information to make informed selling decisions.

**How the App Helps:**
- The app aggregates average property prices in their area, enabling sellers to price their homes competitively.
- Provides comparison tools to analyze similar properties effectively.

### User Authentication

Given the potential for inappropriate content, consider implementing user authentication:

- **Restricted Access:** Limit certain functionalities to users with a valid @ucsb.edu email address.
- **Content Moderation:** Implement a reporting system for inappropriate content and a review process to ensure a safe user experience.
- **Profile Verification:** Offer options for users to verify their profiles to enhance trust and accountability in the community.



### Installation
### Prerequisites
TODO: List what a user needs to have installed before following your installation instructions (e.g. which version(s) of what framework(s), if any). The challenge is to eventually deploy a mobile app from your GitHub repo on the press of a button. For the near term, you can decide to make an off-line generated package (apk for Android or ipa for IOS) available as the latest binary distribution, but at some point during this class, there will be a requirement to generate this package from your current code base automatically.

### Dependencies
TODO: List which libraries / add-ons you added to the project, and the purpose each of those add-ons serves in your app.

### Installation Steps
TODO: Describe the installation process (making sure you give complete instructions to get your project going from scratch). Instructions need to be such that a user can just copy/paste the commands to get things set up and running. Note that with the use of GitHub Actions, these instructions can eventually be fully automated (e.g. with act, you can run GitHub Actions locally).

### Functionality
TODO: Write usage instructions. Structuring it as a walkthrough can help structure this section, and showcase your features.

### Known Problems
TODO: Describe any known issues, bugs, odd behaviors or code smells. Provide steps to reproduce the problem and/or name a file or a function where the problem lives.

### Contributing
TODO: Leave the steps below if you want others outside your team to contribute to your project.

Fork it!
Create your feature branch: git checkout -b my-new-feature
Commit your changes: git commit -am 'Add some feature'
Push to the branch: git push origin my-new-feature
Submit a pull request :D
### License
If you haven’t already, add a file called LICENSE.txt with the text of the appropriate license. We recommend using the MIT license: https://choosealicense.com/licenses/mit/”
