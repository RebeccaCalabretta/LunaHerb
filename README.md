# LunaHerb
![LunaHerb_darkBlueBG](https://github.com/user-attachments/assets/c3e4e0da-976f-4daa-b709-96c1428a59c7)

LunaHerb is a Swift-based iOS application that combines the world of medicinal herbs with the influence of the phases of the moon. The app offers a comprehensive database of medicinal herbs and their uses, shows favorable planting and harvesting times based on the current moon position and allows you to search for ailments to find suitable herbs. 

## Index

[Screenshots](#Screenshots)

[Installation](#Installation)

[Features](#Features)

[iOS Technology and Architecture](#iOS-Technology-Implementation)

[Libraries](#Libraries)

[Contact/Authors](#Contact/Authors)

## Screenshots

## Installation

1. clone the LunaHerb project with Git
   ```git
   git clone https://github.com/RebeccaCalabretta/LunaHerb.git
   ```

3. open the project in Xcode

4. start the app on an iOS device or the iOS simulator

## Features

🪴 **Healing herbs database**: Contains detailed information on medicinal herbs, their effects & applications.

⏰ **Planting and harvesting time**: Shows recommended times, based on the lunar cycle.

🔍 **Search function**: Shows herbs according to symptoms / ailments.

💚 **Save favorites**: Favorite herbs are saved for faster access.

🚫 **Offline mode**: Access data after initial download even without an internet connection.

## iOS Technology and Architecture

- **[MVVM Pattern](https://www.avanderlee.com/swiftui/mvvm-architectural-coding-pattern-to-structure-views/)**
- **[SwiftUI](https://developer.apple.com/documentation/SwiftUI)**
- **[SwiftData](https://developer.apple.com/documentation/SwiftData)**
- **[CoreLocation](https://developer.apple.com/documentation/CoreLocation)**
- **[URLSession](https://developer.apple.com/documentation/foundation/urlsession)**

## Libraries

**[SwiftData](https://developer.apple.com/documentation/SwiftData)**: Store and retrieve herbal data

**[EKAstrologyCalc](https://github.com/emvakar/EKAstrologyCalc)**: Retrieve data on the current moon position

## API
**[WeatherAPI](https://www.weatherapi.com/docs/)**: Retrieve current weather data

## Backend Integration

LunaHerb was developed for offline-friendly use:

**Database with SwiftData**: All herb and moon phase information is stored locally on the device.

**Customization**: Users can create their own favorites and enter reminders - all without an internet connection.

## Author/Contact

RebeccaCalabretta


