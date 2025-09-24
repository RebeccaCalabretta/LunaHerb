# LunaHerb
<div align="center">
  <img src="https://github.com/user-attachments/assets/d9ac177b-9793-4985-b39b-8a0e3cca58bc" 
       alt="LunaHerb Dark Blue Background" 
       style="max-width: 100%; height: auto;">
</div>
LunaHerb is a Swift-based iOS application that combines the world of medicinal herbs with the influence of the phases of the moon. The app offers a comprehensive database of medicinal herbs and their uses, shows favorable planting and harvesting times based on the current moon position and allows you to search for ailments to find suitable herbs. 

## 📌 Index

[Screenshots](#Screenshots)

[Installation](#Installation)

[Features](#Features)

[iOS Technology and Architecture](#iOS-Technology-Implementation)

[Libraries](#Libraries)

[Contact/Authors](#Contact/Authors)

## 📸 Screenshots

<p align="center">
  <img src="screenshots/moon-dark.png" width="180"/>
  <img src="screenshots/herb-detail-dark.png" width="180"/>
  <img src="screenshots/herb-list-light.png" width="180"/>
  <img src="screenshots/herb-list-dark.png" width="180"/>
  <img src="screenshots/settings-light.png" width="180"/>
</p>

## 🛠️ Installation

1. clone the LunaHerb project with Git
   ```git
   git clone https://github.com/RebeccaCalabretta/LunaHerb.git
   ```

3. open the project in [Xcode](https://developer.apple.com/xcode/)

4. start the app on an iOS device or the iOS simulator

## ✨ Features

🪴 **Healing herbs database**: Contains detailed information on medicinal herbs, their effects & applications.

⏰ **Planting and harvesting time**: Shows recommended times, based on the lunar cycle.

🔍 **Search function**: Shows herbs according to symptoms / ailments.

💚 **Save favorites**: Favorite herbs are saved for faster access.

🚫 **Offline mode**: Access data after initial download even without an internet connection.

## 🏛️ iOS Technology and Architecture

- **[MVVM Pattern](https://www.avanderlee.com/swiftui/mvvm-architectural-coding-pattern-to-structure-views/)**: Model-View-ViewModel; separation of data, display and logic for a clean code structure
- **[SwiftUI](https://developer.apple.com/documentation/SwiftUI)**: UI toolkit for a modern user interface that enables reactive and component-based programming
- **[SwiftData](https://developer.apple.com/documentation/SwiftData)**: Fast, powerful and simple framework for storing and managing data
- **[CoreLocation](https://developer.apple.com/documentation/CoreLocation)**: Framework for obtaining location-based information such as GPS data for location-dependent functions
- **[URLSession](https://developer.apple.com/documentation/foundation/urlsession)**: A class in the Foundation Framework to send and receive data via the web

## 📚 Libraries

**[EKAstrologyCalc](https://github.com/emvakar/EKAstrologyCalc)**: Retrieve data on the current moon position

## ⬇️ API
**[WeatherAPI](https://www.weatherapi.com/docs/)**: Retrieve current weather data

## 💾 Backend Integration

### LunaHerb was developed for offline-friendly use:

• **Database with SwiftData**: All herb and moon phase information is stored locally on the device.

• **Customization**: Users can create their own favorites and enter reminders - all without an internet connection.

## 🔮 Future developments

**Plant scanner**: Make sure you collect the right herbs

**Aromatherapy**: List of helpful essential oils

## ✍️ Author/Contact

www.linkedin.com/in/rebecca-calabretta-b63617319


