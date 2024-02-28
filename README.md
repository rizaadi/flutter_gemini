# Flutter Gemini

Demonstrates Gemini AI in flutter using [BloC](https://pub.dev/packages/flutter_bloc) State Management and [Google AI Dart SDK](https://pub.dev/packages/google_generative_ai) 

## Features

|Text Only| Text and Image| Multi-turn conversations (chat)|
|---------|---------------|--------------------------------|
| <video src="https://github.com/rizaadi/flutter_gemini/assets/74534061/07483368-61a7-47b6-b7cb-7bbb35fa6b83"> |<video src="https://github.com/rizaadi/flutter_gemini/assets/74534061/165b9b96-3092-4a53-b16b-a45ee5ca2a43">|<video src="https://github.com/rizaadi/flutter_gemini/assets/74534061/20b238e2-959b-46b6-8a0e-410e5baebff4">|

## Architecture
The architecture is implemented using the BLoC and Repository patterns.
![architecture](https://github.com/rizaadi/flutter_gemini/assets/74534061/df982650-bebd-4b5f-8032-35574e416e58)

## Setup and Installation

1. To use the Gemini API, you'll need an API key. If you don't already have one, create a key in [Google AI Studio](https://makersuite.google.com/app/apikey).
2. Clone the repository from GitHub:
```
git clone https://github.com/rizaadi/flutter_gemini.git
```
3. Get all dependencies:
```
flutter pub get
```
4. Create a `.env` file and fill it with your api
```
GEMINI_KEY='YOUR API KEY'
```
4. Run the app:
```
flutter run
```
