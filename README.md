# ISTAD Mobile

<div align="center">
  <img src="assets/images/logo.png" alt="ISTAD Mobile Logo" width="200" height="auto"/>
</div>

## About 📱

ISTAD Mobile is an innovative educational platform designed to centralize academic and student-related information. The app aims to enhance accessibility to academic resources, simplify administrative processes, and deliver personalized learning experiences for students and educators.

### Key Objectives
- Provide centralized access to academic information
- Streamline student-related processes
- Deliver personalized user experiences
- Support multiple study programs
- Bridge technology gaps in education

## Features 🎯

- 📚 Course Management
    - Browse available courses
    - Track course progress
    - Access course materials

- 🎓 Student Portal
    - View academic records
    - Track attendance
    - Access study materials

- 🏛️ Academic Resources
    - Digital library access
    - Course schedules
    - Academic calendar

- 🔔 Smart Notifications
    - Course updates
    - Assignment deadlines
    - Important announcements

- 🏫 Admission Management
    - Online applications
    - Application status tracking
    - Document submission

- 📊 Learning Management System
    - Assignment submission
    - Grade tracking
    - Interactive learning materials

## Getting Started 🚀

### Prerequisites

Ensure you have the following installed:
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or Visual Studio Code
- Xcode (for iOS development)
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/ISTAD-Mobile/LMS-Flutter-Project.git
```

2. Navigate to project directory
```bash
cd lms_flutter_project
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the application
```bash
flutter run
```

## Project Structure 📁

```
lib/
│   main.dart             # Application entry point
│
├───data/                 # Data layer
│   ├───color/            # API services
├───├───network/          # API services
│   └───response/         # API response
│
├───models/               # Data models
│
├───repository/           # Data repositories
│
├───resources/ 
│
├───views/                # UI screens
│   ├───screen/
│   ├───Skelaton/  
    ├───widgets/       
│   └───home/
│
└───viewmodel/            # Business logic
```

## Dependencies 📦

Key dependencies include:
```yaml
name: lms_mobile
description: "A new Flutter project."
publish_to: 'none'
version: 1.0.0+1
environment:
  sdk: ^3.5.3
dependencies:
  flutter:
    sdk: flutter
  video_player: ^2.9.2
  flutter_carousel_widget: ^3.1.0
  carousel_slider: ^5.0.0
  image_picker: ^1.1.2
  flutter_typeahead: ^5.2.0
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.0.16
  url_launcher: ^6.0.0
  lottie: ^3.1.3
  google_maps_flutter: ^2.10.0
  intl: ^0.20.1
  connectivity_plus: ^6.1.0
  provider: ^6.1.2
  skeletonizer: ^1.4.2
  dotted_border: ^2.1.0
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.4
  jwt_decoder: ^2.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/animation/
  fonts:
    - family: NotoSansKhmer
      fonts:
        - asset: assets/fonts/NotoSansKhmer-Bold.ttf
          weight: 700
        - asset: assets/fonts/NotoSansKhmer-Medium.ttf
          weight: 500
        - asset: assets/fonts/NotoSansKhmer-Regular.ttf
          weight: 400
        - asset: assets/fonts/NotoSansKhmer-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/NotoSansKhmer-ExtraBold.ttf
          weight: 800
        - asset: assets/fonts/NotoSansKhmer-Black.ttf
          weight: 900
    - family: RobotoEnglish
      fonts:
        - asset: assets/fonts/Roboto-Black.ttf
          weight: 900
        - asset: assets/fonts/Roboto-Bold.ttf
          weight: 700
        - asset: assets/fonts/Roboto-MediumItalic.ttf
          weight: 500
        - asset: assets/fonts/Roboto-Regular.ttf
          weight: 400
        - asset: assets/fonts/Roboto-Thin.ttf
          weight: 100
```

## Documentation 📚

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/)
- [Package Repository](https://pub.dev/)

## Troubleshooting 🔧

If you encounter any issues:

1. Update Flutter
```bash
flutter upgrade
```

2. Verify Flutter installation
```bash
flutter doctor
```

3. Clean and rebuild
```bash
flutter clean
flutter pub get
```

## Contributors 👥

- [Nhoem_Tevy](https://github.com/nhoemtevy)
- [Leang_Naikim](https://github.com/leangbunleap)
- [Heng_Sothib](https://github.com/chantreafullstack)
- [Noun_Sovanthorn](https://github.com/sovanthorn)

## Screens 📱

- Home Screen
- LMS Dashboard
- Academic Portal
- About ISTAD
- Admission Portal
- Course Catalog
- Enrollment System
- Project Achievement Gallery

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

<div align="center">
  <p>Built with ❤️ by ISTAD Mobile Team</p>
</div>