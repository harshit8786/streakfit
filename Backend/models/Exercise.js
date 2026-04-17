const mongoose = require('mongoose');

const ExerciseSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String },
  duration: { type: Number, default: 0 }, // in minutes
  target: { type: String, required: true }, // e.g., 'Back', 'Legs'
  difficulty: { type: String, enum: ['Easy','Medium','Hard'], default: 'Easy' },
  day: { type: String, required: true } // e.g., 'Monday'
}, { timestamps: true });

module.exports = mongoose.model('Exercise', ExerciseSchema);