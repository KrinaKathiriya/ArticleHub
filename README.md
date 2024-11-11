# Article Hub

**Article Hub** is a mobile application that allows users to read articles from various sources, save their favorite articles, and view articles in detail.

## Features

- Fetch articles dynamically from an API.
- Save articles to local cache for offline reading.
- View detailed information for each article.
- Search articles based on the title.
- Show a custom no internet connection screen when offline.

## Installation

To install **Article Hub**, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/KrinaKathiriya/ArticleHub.git
2. Open the project in Xcode by tapping on reader.xcworkspace.
3. Install any dependencies or frameworks, if necessary.
4. Make sure you have selected reader as your current scheme for running destination.
5. If running this project on device please make sure you have selected the Siging Team in Signing & Capabilities section.
6. Build and run the project on a simulator or device.

## Usage

1. Launch the app to see the list of articles displayed on the main screen.
2. Tap on any article to view its detailed content.
3. Use the search button to filter articles based on their title.

## Dependencies
- Alamofire: For networking and fetching articles from the API.
- Kingfisher: For image loading and caching.
- FTLinearActivityIndicator: For showing activity indicators during network requests when image is loading or articles are being fetched.
- Lottie: For displaying animated assets in the app.
- AlamofireNetworkActivityIndicator: for handling network activity indicator visibility based on network requests.
- XCGLogger : For logging network request
- ReachabilitySwift : Used to check the device's network connectivity status.
- Loaf : Used to show toast messages

## Directory Structure
The project follows a simple directory structure:
```bash
reader/
│
├── AppDelegate.swift                # Handles app lifecycle and initialization.
├── Assets.xcassets                  # Contains image and asset resources.
├── Info.plist                       # App configuration file.
├── LaunchScreen.storyboard          # Displays the initial screen when the app launches.
│
├── Assets/
│   ├── Fonts/
│   │   └── Roboto/
│   │       └── All Fonts            # Contains all the Roboto fonts used in the app.
│   ├── LottieAnimations/
│   │   └── All Lottie Animation     # Lottie animations used in the app.
│
├── Helper/
│   ├── Extension+Date.swift         # Extensions for Date handling (e.g., formatting dates).
│   ├── Extension+String.swift       # Extensions for String handling (e.g., toDate).
│   ├── Extension+UIViewController.swift # Adds functionality to UIViewController (e.g., setting up nav bars).
│   ├── Extension+UIView.swift       # Adds functionality to UIView (e.g., drop shadows).
│   └── Extension+Userdefaults.swift # Custom extensions for UserDefaults handling.
│
├── Managers/
│   ├── Clients/
│   │   ├── CacheManager.swift       # Handles caching of articles for offline use.
│   │   └── ReachabilityManager.swift # Monitors network connectivity.
│   └── Core/
│       └── ArticleService.swift     # Manages fetching articles from the network.
│
├── Models/
│   ├── ArticleAPIResponseModel/
│   │   ├── ArticleResponse.swift   # Model representing the response from the article API.
│   │   ├── Articles.swift          # Model representing an individual article.
│   │   └── Source.swift            # Model for article source information.
│
├── ViewControllers/
│   ├── Core/
│   │   ├── Cells/
│   │   │   └── ArticleTableViewCell.swift  # Custom table view cell for displaying articles.
│   │   └── Views/
│   │       ├── Main.storyboard     # Main UI storyboard for the app.
│   │       ├── ArticleDetailViewController.swift # Displays the detailed content of an article.
│   │       ├── ArticleListViewController.swift   # Displays the list of articles.
│   │       └── NoInternetViewController.swift   # Displays "No Internet" screen when offline.
```

## Screenshots

![Simulator Screenshot - iPhone 16 Pro - 2024-11-11 at 13 03 34](https://github.com/user-attachments/assets/b567882a-68b3-43b3-b1fc-04549649dee9)

![Simulator Screenshot - iPhone 16 Pro - 2024-11-11 at 13 03 29](https://github.com/user-attachments/assets/fb78471e-0d3c-4901-b0a7-97207ee047df)




