# Smart Calculator App

A feature-rich calculator application with advanced features, built with Flutter.

## Features

- **Basic and Scientific Calculator**: Complete mathematical operations with a beautiful and
  intuitive interface
- **Smart Solver Mode**: Type natural language math questions like "What is 25% of 350?" and get
  instant answers
- **Step-by-Step Solutions**: See detailed explanations of how each problem is solved
- **Customizable Keypad**: Rearrange calculator buttons to suit your preferences
- **Sound Effects**: Enjoyable button press sounds with multiple themes (default, retro, bubble,
  techy)
- **Daily Challenges**: Practice math skills with daily puzzles
- **Easter Eggs**: Hidden features like secret themes
- **Split Screen Calculator**: Work on two calculations side by side
- **History with Local Storage**: Save your calculation history on your device
- **Multilingual Support**: Available in English, Tamil, Hindi, and Spanish
- **AR Scanner**: Point your camera at a written math problem to solve it
- **Multiple Themes**: Light, dark, professional, and fun themes
- **Voice Readout**: Option to have results read aloud

## Setup Instructions

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

### Additional Setup

For AR scanning functionality:

- Add proper camera permissions in your AndroidManifest.xml and Info.plist files
- Add sound files in the assets/sounds/ directory with naming format:
    - default_click.mp3
    - retro_click.mp3
    - bubble_click.mp3
    - techy_click.mp3

## Technology Stack

- Flutter
- Provider for state management
- SharedPreferences for local data storage
- Google ML Kit for text recognition
- Flutter TTS for text-to-speech functionality

## Requirements

- Flutter 3.0+
- Dart 2.17+
- Android 5.0+ or iOS 11.0+

## License

This project is licensed under the MIT License - see the LICENSE file for details.