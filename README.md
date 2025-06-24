# Babylon Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.8.0%2B-blue)](https://flutter.dev)
[![Build](https://img.shields.io/badge/build-passing-brightgreen)](#)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](#)

---

## Overview

**Babylon Flutter App** is a modern, cross-platform Flutter application that demonstrates best practices in authentication, Firestore integration, robust form validation, and clean UI/UX. This project was built as a take-home interview assignment to showcase:

- Clean architecture and code organization
- Comprehensive testing (unit, widget, and integration with mocks)
- Professional documentation and developer experience

---

## Features

- **Login Page**

  - Email and password login with validation
  - Error handling for invalid credentials and non-existent users
  - Password visibility toggle
  - Animated loading state
  - SnackBar feedback for all outcomes

- **Signup Page**

  - First name, last name, email, and password fields
  - Strong validation for all fields (length, format, allowed characters)
  - Checks for existing email in Firestore
  - Success and error feedback via SnackBar

- **Home Page**

  - Drawer with user info, navigation, and logout
  - Bottom navigation bar (Dashboard, Explore, Profile)
  - Personalized welcome message from Firestore

- **Firebase Integration**

  - Uses `firebase_auth` for authentication
  - Uses `cloud_firestore` for user data
  - Ready for analytics with `firebase_analytics`

- **Testing**
  - Widget and unit tests for login and signup validation
  - Widget test for login with mocked FirebaseAuth and Firestore
  - Uses `mockito` for dependency injection and mocking

---

## Screenshots

> **Tip:** Place your screenshots in a `screenshots/` folder and reference them below. Example:

![Login Screen](screenshots/login.png)
![Signup Screen](screenshots/signup.png)
![Home Screen](screenshots/home.png)

---

## Technical Decisions

- **State Management:** Used [provider](https://pub.dev/packages/provider) for simplicity and scalability.
- **Testing:** Used [mockito](https://pub.dev/packages/mockito) for mocking Firebase dependencies, ensuring robust and isolated tests.
- **Firebase:** Chosen for real-time database and authentication, matching modern app requirements.
- **UI/UX:** Material 3 design, custom gradients, and responsive layouts for a modern look and feel.
- **Routing:** Used Flutter's built-in `Navigator` and named routes for clarity and maintainability.

---

## Getting Started

### Prerequisites

- Flutter SDK (>=3.8.0)
- Dart 3.8.0 or newer
- Firebase project (with iOS/Android/web configs)

### Installation & Setup

1. **Clone the repository:**

   ```sh
   git clone <your-repo-url>
   cd babylon_flutter_app
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**

   - Add your `GoogleService-Info.plist` (iOS/macOS) and `google-services.json` (Android) to the respective platform folders.
   - Make sure `firebase_options.dart` is generated (run `flutterfire configure` if needed).

4. **Run the app:**
   - **Android/iOS:**
     ```sh
     flutter run
     ```
   - **Web:**
     ```sh
     flutter run -d chrome
     ```
   - **macOS/Linux/Windows:**
     ```sh
     flutter run -d macos  # or -d linux / -d windows
     ```

---

## Project Structure

```
lib/
  main.dart                # App entry point, routing
  pages/
    login_page.dart        # Login UI and logic
    signup_page.dart       # Signup UI and logic
    home_page.dart         # Home/dashboard UI
  firebase_options.dart    # Firebase config (auto-generated)
test/
  login_page_test.dart         # Widget & validation tests for login
  signup_validation_test.dart  # Widget & validation tests for signup
  login_firestore_test.dart    # Widget test for login with mocked Firebase
```

---

## Running Tests

To run all tests:

```sh
flutter test
```

- Tests cover form validation, error handling, and Firebase/Firestore integration (with mocks).
- To regenerate mocks after changing test annotations:
  ```sh
  flutter pub run build_runner build
  ```

---

## Troubleshooting

- **Firebase errors:** Ensure your Firebase config files are in the correct platform folders and `firebase_options.dart` is up to date.
- **Tests fail due to mocks:** Run `flutter pub run build_runner build` to regenerate mock files after changing test annotations.
- **Platform-specific issues:** Make sure you have the correct platform SDKs and emulators installed.
- **Hot reload not working:** Try `flutter clean` and restart your IDE.

---

## Future Improvements

- Add password reset functionality.
- Improve accessibility (a11y) and localization.
- Add integration tests for navigation flows.
- Enhance UI with animations and transitions.
- Add CI/CD pipeline for automated testing and builds.
- Add dark mode and theme customization.
- Add user profile editing and avatar upload.

---

## Customization

- Update the color scheme and branding in `main.dart` and page widgets.
- Extend the home page with more tabs or features as needed.
- Add more tests for new features to ensure reliability.

---

## Contact

For questions, contact **Your Name** at [your.email@example.com].

---

## License

This project is for educational/demo purposes. Add your own license as needed.
