# Flashback 🍜

A personal restaurant and cafe memory diary app built with Flutter. Explore cafes near you, log food memories with photos and ratings, browse your timeline, and share experiences with friends.

> Built as a portfolio project while learning Flutter — transitioning from a React/Node.js background into mobile development.

---

## Screenshots

### Home Screen
![Home Screen 1](screenshots/home_screen_01.png)
![Home Screen 2](screenshots/home_screen_02.png)

### Cafe Detail Screen
![Cafe Detail](screenshots/cafe_detail.png)

### Log Memory Screen
![Log Memory](screenshots/log_memory.png)

### Timeline Screen
![Timeline](screenshots/user_timeline.png)

### Profile Screen
![Profile](screenshots/user_profile.png)

---

## Features

- **Explore** — Browse nearby cafes and restaurants with horizontal featured cards and filter chips
- **Cafe Detail** — Full cafe profile with hero image, tags, location, timings, about section, and food memories grid
- **Log Memory** — Upload a photo, enter item name, price, star rating (1–5), and personal notes
- **Timeline** — Chronological feed of all saved memories grouped by month
- **Google Maps** — Map view with custom cafe markers and bottom sheet on tap *(in progress)*
- **Profile** — User stats (cafes visited, items logged, avg rating), favorite dishes, and settings
- **Firebase Backend** — Firestore for data, Firebase Storage for photos, Firebase Auth for login *(in progress)*
- **Offline Support** — Firestore local caching so app works without internet

---

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Flutter (Dart) |
| State Management | Provider |
| Backend | Firebase (Firestore, Auth, Storage) |
| Maps | Google Maps Flutter |
| Design | Figma |
| Version Control | Git / GitHub |

---

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/
│   └── cafe.dart              # CafeData & FoodMemory models
├── data/
│   └── dummy_data.dart        # Static data (Firebase replacement coming)
├── screens/
│   ├── home_screen.dart       # Explore cafes
│   ├── cafe_detail_screen.dart # Cafe profile + memories
│   ├── log_memory_screen.dart  # Add a new memory
│   ├── timeline_screen.dart    # All memories chronologically
│   ├── map_screen.dart         # Google Maps view (in progress)
│   └── profile_screen.dart    # User profile & settings
└── widgets/
    ├── featured_card.dart      # Horizontal scroll cafe card
    └── cafe_list_card.dart     # Vertical list cafe card
```

---

## Getting Started

### Prerequisites

- Flutter SDK 3.x — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Android Studio (for emulator) or a physical Android device
- Google Maps API key
- Firebase project

### Run Locally

```bash
# Clone the repo
git clone https://github.com/IramBashir/flashback.git
cd flashback

# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Run on Android emulator or device
flutter run
```

### Environment Setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable Firestore, Authentication, and Storage
3. Download `google-services.json` and place in `android/app/`
4. Add your Google Maps API key in `android/app/src/main/AndroidManifest.xml`

---

## Current Status

| Feature | Status |
|---------|--------|
| Home Screen UI | ✅ Complete |
| Cafe Detail Screen | ✅ Complete |
| Log Memory Form | ✅ Complete |
| Timeline Screen | ✅ Complete |
| Profile Screen | ✅ Complete |
| Google Maps Integration | 🔄 In Progress |
| Firebase Backend | 🔄 In Progress |
| Image Picker (Camera/Gallery) | 🔄 In Progress |
| Friends Sharing | 📋 Planned |
| App Store Deployment | 📋 Planned |

---

## About the Developer

**Iram Bashir**
MS Computer Science — FAST-NUCES, Islamabad

Previously worked as a Software Developer at Jin Tech (1 year) building full-stack web apps with React, TypeScript, Node.js, and NestJS. Currently learning Flutter and transitioning into mobile development.

- GitHub: [github.com/IramBashir](https://github.com/IramBashir)
- LinkedIn: [linkedin.com/in/irambashir](https://www.linkedin.com/in/irambashir/)

