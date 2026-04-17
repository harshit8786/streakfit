# StreakFit

StreakFit is a fitness tracker app with a Flutter frontend and a Node.js + Express backend.

It helps users:
- sign up and log in
- browse workouts day-wise
- view body-part-based exercise groups inside each day
- track workout time with a stopwatch
- mark exercises as completed
- follow a weekly workout split with Sunday as a rest day

## Project Structure

```text
streakFit/
├── Backend/           # Node.js + Express + MongoDB backend
├── streakfit_app_fr/  # Flutter frontend
└── README.md
```

## Features

- User authentication
- Day-wise workout schedule
- Grouped exercises by body part
- Sunday rest day screen
- Stopwatch on exercise detail screen
- Sets tracking and workout progress helpers
- Exercise completion flow
- Clean light UI with a decent color palette

## Tech Stack

### Frontend
- Flutter
- Provider
- Shared Preferences
- HTTP package

### Backend
- Node.js
- Express
- MongoDB
- Mongoose
- JWT authentication

## How To Run

### 1. Run the backend

Open terminal in:

```bash
cd /Users/harshitsingh/Desktop/streakFit/Backend
```

Install dependencies if needed:

```bash
npm install
```

Start the backend:

```bash
npm start
```

For development mode:

```bash
npm run dev
```

### 2. Seed workout data

To load the weekly exercises into MongoDB:

```bash
cd /Users/harshitsingh/Desktop/streakFit/Backend
npm run seed
```

### 3. Run the Flutter app

Open the frontend folder in Android Studio:

```bash
/Users/harshitsingh/Desktop/streakFit/streakfit_app_fr
```

Or run from terminal:

```bash
cd /Users/harshitsingh/Desktop/streakFit/streakfit_app_fr
flutter pub get
flutter run
```

## Backend Environment Variables

Create a `.env` file inside `Backend/` with:

```env
PORT=5001
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key
```

## API Base Port

This project is currently set up to use:

```text
http://localhost:5001
```

## Weekly Workout Split

- Monday: Chest, Triceps
- Tuesday: Back, Biceps
- Wednesday: Legs, Calves
- Thursday: Shoulders, Core
- Friday: Chest, Back
- Saturday: Full Body, Cardio
- Sunday: Rest Day

## Future Improvements

- Exercise history
- Streak analytics
- Countdown timer
- Rest timer between sets
- Progress charts

## Author

Harshit Singh
