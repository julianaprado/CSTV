# CSTV

The CSTV displays CS: GO matches happening across several worldwide tournaments.

# Inferface

![‎Screens](https://github.com/julianaprado/CSTV/assets/50370069/296689cc-2282-41df-a249-3f4ed645c165)

# Features
- Displays all matches chronologically

- Displays match details
- Native launch screen
- Custom launch screen with animation

# Arquitecture and Structure

The project uses SwiftUi and the MVVM architecture. Project Structure:

- Utils: Code that is used throughout the project is stored here.
  - Views: Generic views used everywhere in the project.
  - Constants: Static constants used to store the strings used in the project.
  - Extensions: Generic extensions.
- Models: Structs used to populate the api results.
- Network: The Network Manager deals with preparing the URLRequest and fetching from the api with Combine.
  - Enums: Enums used for the Network Manager
- Scenes: Where the Views and their respective View-Models reside. If a view uses multiple smaller views, they will be separated by group.
  - View-Model: Responsible for the View logic.
  - View: User Interface

# Libraries Used

- SwiftLint
- SwiftUI CachedAsyncImage

# Minimum Requirements

- iOS 15+
- Swift 5
- SwiftUI 3.0

# Run the Project

1. Clone git project: https://github.com/julianaprado/CSTV.git
2. Open the file CSTV.xcodeproj with Xcode.
3. Cmd + R
