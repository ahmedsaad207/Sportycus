# Sportycus

Sportycus is a multi-sport iOS application built with Swift using the MVP architecture.  
The app allows users to explore leagues, matches, teams, and players across four major sports: Football, Basketball, Tennis, and Cricket.

## Features

- Animated splash screen with smooth transition
- Tab bar with two main sections:
  - Home: Choose a sport and browse its leagues
  - Favourites: Save and access your favourite leagues
- Detailed league screen showing:
  - Last and upcoming matches
  - Teams or players (Tennis shows players only)
- Team details screen (for team-based sports) displaying players, coaches, and related information
- Save favourite leagues locally using CoreData
- Supports device rotation
- Detects offline mode using Reachability and prevents navigation when offline

## Technologies Used

| Technology     | Description                                |
|----------------|--------------------------------------------|
| Swift          | Programming language                       |
| MVP Architecture | Code architecture pattern               |
| CoreData       | Local storage for favourites               |
| Reachability   | Network connectivity monitoring            |
| UIKit          | User interface and view customization      |

## API

Sportycus uses the [AllSportsAPI](https://allsportsapi.com/) to fetch real-time sports data, including matches, teams, players, and leagues.

## Contributors

- Ahmed Mohamed Saad  
- Youssif Nasser Mostafa

## Installation

```bash
# Clone the repository
git clone https://github.com/ahmedsaad207/Sportycus.git

# Open the project in Xcode
open Sportycus.xcodeproj

# Run the app on your simulator or device
```

## Contact

For questions or suggestions, feel free to reach out to the contributors:

- [Ahmed Mohamed Saad](https://www.linkedin.com/in/dev-ahmed-saad/)
- [Youssif Nasser Mostafa](https://www.linkedin.com/in/youssif-nasser/)



