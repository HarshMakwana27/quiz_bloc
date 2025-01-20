
# Flutter Quiz App

## Overview

This project is a Flutter-based quiz application developed for the **Flutter Interview Round 1: Quiz Flow with Gamification**. The app demonstrates a simple quiz flow, fetching data from an API endpoint, presenting questions one by one, and displaying a detailed results summary upon completion. The app is designed with responsiveness and user engagement in mind.

---

## Features

- **Start Quiz**: A straightforward button to begin the quiz.
- **Dynamic Question Flow**: Questions are presented one at a time, with an intuitive option selection mechanism.
- **Detailed Summary**: A results summary displays the total score and answers (both correct and incorrect) after quiz completion.
- **Data Integration**: The app fetches quiz data from the API endpoint: https://api.jsonserve.com/Uw5CrX.
- **Error Handling**: Handles API errors gracefully to ensure a smooth user experience.

---
## Screenshots

### Home Page
<img src="https://github.com/user-attachments/assets/bdb832db-ab3a-4d4f-a2ab-7ce9f499a6f3" alt="home" width="400"/>

### Quiz Screen
<img src="https://github.com/user-attachments/assets/ee17662e-9316-4059-a6df-90d58b571f68" alt="quiz1" width="400"/>
<img src="https://github.com/user-attachments/assets/01e6c376-a160-44a2-a3fc-9c388e0bc25e" alt="quiz2" width="400"/>

### Summary Screen
<img src="https://github.com/user-attachments/assets/e759ab10-3d52-4295-911d-b1cfbe77cecc" alt="summary" width="400"/>

---

## Installation Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd quiz_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## API Integration

The app fetches quiz data from the following endpoint:
- **Endpoint**: `https://api.jsonserve.com/Uw5CrX`

Ensure your device or emulator has internet access to retrieve the quiz data.

---

## Technical Details

### Framework & Language
- Flutter
- Dart

### Architecture
- **State Management**: `flutter_bloc` for managing the quiz flow state.

### Folder Structure
- `lib/`: Main application code.
  - `bloc/`: BLoC files for state management.
  - `data/`: Contains models and repository for API integration.
  - `pages/`: UI screens for the app.

---

## Evaluation Criteria

- **Accuracy of Data Integration**: Quiz data is fetched and displayed as intended.
- **UI Quality**: Clean, intuitive, and responsive design.
- **Interactivity**: Smooth user interactions for question navigation and answer selection.
- **Code Quality**: Clean, maintainable, and well-documented code structure.

---

## Gamification & User Engagement

- Intuitive UI for better quiz-taking experience.
- Clear feedback on correct/incorrect answers in the results summary.

---



## Author

Developed by Harsh Makwana
