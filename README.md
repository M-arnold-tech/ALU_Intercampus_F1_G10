# ALU Intercampus Connect

A mobile-first platform that strengthens student engagement and collaboration within the African Leadership University ecosystem.

---

## Overview

ALU Intercampus Connect is a Flutter-based mobile application that brings together students from Kigali and Mauritius campuses. The platform allows authorized users (club leaders, event organizers, entrepreneurs, student communities, and academic teams) to post opportunities including events, hackathons, workshops, startup initiatives, leadership programs, internships, and community announcements.

---

## Features

### Core Features

- **Authentication & Onboarding** - Sign up/login with @alustudent.com email validation
- **Dynamic Feed** - Browse opportunities with category filters (All, Events, Opportunities, Clubs, Academics)
- **RSVP Management** - RSVP or mark "interested" for events with real-time counters
- **Mentorship Matching** - AI-matched alumni mentor suggestions with match percentages
- **Chat Interface** - Direct messaging with event groups and community spaces
- **User Profile** - Personal information, interests, and participation history
- **Study Groups** - Create and join study groups across campuses
- **Notifications** - Stay updated on events, messages, and RSVP reminders

### Unique Features

- **Multi-Campus Support** - Connect students in Kigali and Mauritius
- **Smart Onboarding** - Campus and interest selection to personalize the feed
- **AI-Powered Mentor Matching** - Personalized mentor recommendations based on interests

---

## Tech Stack

- **Framework**: Flutter (SDK ^3.7.2)
- **Language**: Dart
- **State Management**: `setState` (local state management)
- **Platforms**: Android, iOS, Linux, Windows, macOS, Web

---

## Project Structure

```
alu_intercampus_app/
│
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
│
├── lib/
│   ├── main.dart
│   │
│   ├── onboarding/
│   │   ├── app_theme.dart
│   │   ├── onboarding_controller.dart
│   │   ├── onboarding_scaffold.dart
│   │   ├── onboarding_screen1.dart
│   │   ├── onboarding_screen2.dart
│   │   ├── onboarding_screen3.dart
│   │   ├── onboarding_screen4.dart
│   │   └── onboarding_screen5.dart
│   │
│   └── screens/
│       ├── Auth service.dart
│       ├── Main nav.dart
│       ├── Notification screen.dart
│       ├── chartscreen.dart
│       ├── chatdetail screen.dart
│       ├── create_postscreen.dart
│       ├── eventdetails screen.dart
│       ├── explorescreen.dart
│       ├── homescreen.dart
│       ├── login_screen.dart
│       ├── mentorship screen.dart
│       ├── profilescreen.dart
│       ├── setting screen.dart
│       └── studygroup screen.dart
│
├── assets/
│   └── images/
│
├── test/
│   └── widget_test.dart
│
├── android/
├── ios/
├── linux/
├── macos/
├── windows/
└── web/
```

---

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK (^3.7.2 or higher)
  - [Installation Guide](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code with Flutter extensions
- Git for cloning

### Installation

1. Clone the repository
  ```bash
   git clone https://github.com/M-arnold-tech/ALU_Intercampus_F1_G10.git
  ```
2. Navigate to the project
  ```bash
   cd ALU_Intercampus_F1_G10/alu_intercampus_app
  ```
3. Get dependencies
  ```bash
   flutter pub get
  ```
4. Run the app
  ```bash
   flutter run
  ```
5. Select a device
  - Choose `1` for Linux desktop
  - Choose `2` for Chrome (web)
  - Or connect a physical device or emulator

---

## Demo Login

- **Sign In with ALU Account**:
  - Email: **Must end with `@alustudent.com**` (e.g., `student@alustudent.com`)
  - Password: **Minimum 6 characters**
  - First time? Click **"Create account"** to sign up, then log in.
- **Continue with Google**:
  - Clicking the **Google icon** allows you to sign in using any **Gmail account** for demo purposes.

---

## Color Scheme


| Color      | Hex Code | Usage                             |
| ---------- | -------- | --------------------------------- |
| Navy Blue  | #0F1F4B  | Primary background                |
| Light Navy | #1A2A5E  | Card background                   |
| Gold       | #F5A623  | Accent color, buttons, highlights |
| White      | #FFFFFF  | Text and icons                    |


---

## Screens


| Screen        | Description                           |
| ------------- | ------------------------------------- |
| Auth Screen   | Login/signup with email validation    |
| Onboarding    | Campus and interest selection         |
| Home Feed     | Dynamic opportunities with categories |
| Event Detail  | Event info with RSVP counters         |
| Mentorship    | AI-matched mentor suggestions         |
| Chat          | Direct messaging                      |
| Profile       | User info and settings                |
| Create Post   | Post new opportunities                |
| Study Groups  | Join or create study groups           |
| Notifications | Event and message alerts              |


---

## Troubleshooting

### Common Issues

**Issue: "No file or variants found for asset"**

```bash
flutter clean
flutter pub get
flutter run
```

**Issue: Dependencies not resolving**

```bash
flutter clean
flutter pub cache repair
flutter pub get
```

**Issue: Emulator not showing**

- Start an emulator from Android Studio
- Or connect a physical device via USB
