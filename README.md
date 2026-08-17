# AutoMate - Flutter App

AutoMate is a modern, feature-rich Flutter application designed to simplify vehicle management and maintenance tracking. It provides a sleek and intuitive interface for managing your cars, logging mileage, tracking maintenance schedules, and finding local service centers via an interactive map.

## 🚀 Features

* **Authentication:** Secure login, sign-up, and OTP-based flows with a beautifully animated welcome screen.
* **Vehicle Fleet Management:** Add, edit, and view details of multiple vehicles in your personal garage.
* **Mileage Tracking:** Keep accurate logs of your vehicle's mileage to ensure timely maintenance.
* **Maintenance Reminders:** Automatically calculates due dates for critical maintenance (Engine Oil, Brake Pads, Filters, etc.) based on mileage and time elapsed.
* **Interactive Map:** Built-in `flutter_map` integration featuring OpenStreetMap to dynamically discover and view nearby service centers and specialists.
* **Sleek UI/UX:** A premium, modern design with a glassmorphism dashboard, dynamic animations, and a cohesive dark/light theme structure.

## 🛠 Tech Stack

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** Provider
* **Mapping:** `flutter_map` & `latlong2` (OpenStreetMap integration)
* **Networking:** `http` package
* **Storage:** `flutter_secure_storage` for JWT token and session management
* **Icons:** `lucide_icons`

## 📦 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- Android Studio or Xcode (for emulation/deployment)
- CocoaPods (if running on iOS)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/omarHeshamElkholy/Automate-Flutter.git
   cd Automate-Flutter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure iOS (if running on Mac):
   ```bash
   cd ios
   pod install
   cd ..
   ```

### Running the App

To run the app on a connected device or emulator:

```bash
flutter run
```

## ⚙️ Configuration

The app connects to a secure live backend API. The base URL is configured in the `ApiService`:

```dart
// lib/services/api_service.dart
String get baseUrl {
  return 'https://artsypuff.com/api/v1';
}
```
*Note: If you are running the backend locally for development, change this URL back to `http://localhost:3000/api/v1` (or `10.0.2.2` for Android emulators).*

## 🏗 Project Structure

* `/lib/screens/` - Contains all the UI pages (Dashboard, Garage, Auth, Map, etc.)
* `/lib/widgets/` - Reusable UI components and cards
* `/lib/services/` - API services, secure storage, and network logic
* `/lib/models/` - Data models for parsing JSON responses

## 📄 License

This project is licensed under the MIT License.
