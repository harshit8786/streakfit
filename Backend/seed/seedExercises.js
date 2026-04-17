require('dotenv').config();
const connectDB = require('../config/db');
const Exercise = require('../models/Exercise');


const seed = async () => {
await connectDB();
await Exercise.deleteMany({});


const data = [
{ title: 'Bench Press', description: 'Build chest strength and pressing power', duration: 20, target: 'Chest', difficulty: 'Hard', day: 'Monday' },
{ title: 'Push Ups', description: 'Chest and triceps bodyweight movement', duration: 12, target: 'Chest', difficulty: 'Easy', day: 'Monday' },
{ title: 'Tricep Dips', description: 'Focus on triceps endurance and control', duration: 10, target: 'Triceps', difficulty: 'Medium', day: 'Monday' },
{ title: 'Overhead Tricep Extension', description: 'Isolate triceps with controlled reps', duration: 12, target: 'Triceps', difficulty: 'Medium', day: 'Monday' },

{ title: 'Pull Ups', description: 'Upper back and biceps pulling strength', duration: 10, target: 'Back', difficulty: 'Hard', day: 'Tuesday' },
{ title: 'Deadlift', description: 'Posterior chain and back strength', duration: 20, target: 'Back', difficulty: 'Hard', day: 'Tuesday' },
{ title: 'Barbell Curl', description: 'Basic bicep strength builder', duration: 12, target: 'Biceps', difficulty: 'Easy', day: 'Tuesday' },
{ title: 'Hammer Curl', description: 'Train biceps and forearms together', duration: 12, target: 'Biceps', difficulty: 'Easy', day: 'Tuesday' },

{ title: 'Barbell Squat', description: 'Primary leg strength movement', duration: 20, target: 'Legs', difficulty: 'Hard', day: 'Wednesday' },
{ title: 'Walking Lunges', description: 'Legs and balance training', duration: 15, target: 'Legs', difficulty: 'Medium', day: 'Wednesday' },
{ title: 'Standing Calf Raises', description: 'Improve calf strength and ankle stability', duration: 10, target: 'Calves', difficulty: 'Easy', day: 'Wednesday' },
{ title: 'Seated Calf Raises', description: 'Isolate the lower leg muscles', duration: 10, target: 'Calves', difficulty: 'Easy', day: 'Wednesday' },

{ title: 'Shoulder Press', description: 'Compound shoulder strength exercise', duration: 15, target: 'Shoulders', difficulty: 'Medium', day: 'Thursday' },
{ title: 'Lateral Raises', description: 'Build shoulder width and control', duration: 10, target: 'Shoulders', difficulty: 'Easy', day: 'Thursday' },
{ title: 'Plank', description: 'Core stability and posture control', duration: 5, target: 'Core', difficulty: 'Easy', day: 'Thursday' },
{ title: 'Russian Twists', description: 'Rotate through the core with control', duration: 8, target: 'Core', difficulty: 'Medium', day: 'Thursday' },

{ title: 'Incline Dumbbell Press', description: 'Upper chest pressing movement', duration: 15, target: 'Chest', difficulty: 'Medium', day: 'Friday' },
{ title: 'Cable Fly', description: 'Chest isolation for controlled contraction', duration: 12, target: 'Chest', difficulty: 'Medium', day: 'Friday' },
{ title: 'Lat Pulldown', description: 'Back width and pulling mechanics', duration: 15, target: 'Back', difficulty: 'Medium', day: 'Friday' },
{ title: 'Seated Row', description: 'Middle back strength and posture work', duration: 15, target: 'Back', difficulty: 'Medium', day: 'Friday' },

{ title: 'Burpees', description: 'Full body conditioning and stamina', duration: 10, target: 'Full Body', difficulty: 'Hard', day: 'Saturday' },
{ title: 'Mountain Climbers', description: 'Full body cardio and core work', duration: 8, target: 'Full Body', difficulty: 'Medium', day: 'Saturday' },
{ title: 'Jump Rope', description: 'Improve coordination and cardio fitness', duration: 12, target: 'Cardio', difficulty: 'Easy', day: 'Saturday' },
{ title: 'High Knees', description: 'Fast-paced cardio finisher', duration: 8, target: 'Cardio', difficulty: 'Easy', day: 'Saturday' }
];


await Exercise.insertMany(data);
console.log('Seeded exercises');
process.exit(0);
};


seed().catch(err => { console.error(err); process.exit(1); });
