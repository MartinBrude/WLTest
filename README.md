# Woldline Test

The test consists in developing a client app that shows a set of touristic POIs (Points of Interest) with some details.
The data obtained is persistent with Realm. If the data has been requested before, it is stored and available to retrieve from database the
next time that it will be requested.
The app shows the list of POIs in a Map.
The user can tap a POI and see its detail.
The user can search and filter POIs and reset the filter.

The app follows iOS directives and have an updated style, appropriate for the shown data and the desired functionalities.

## Libraries used
- Alamofire
- RealmSwift
- Swinject

## Getting Started
1. Download (and extract) or clone the project
2. Open terminal and execute sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
3. Run pod install
4. Open the xcworkspace file
5. Run the app

For running the app on a device, you might have to set the development Team in 'General' tab, under Signing section and change the Bundle Identifier. 
