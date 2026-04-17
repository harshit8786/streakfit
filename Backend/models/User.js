const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true, lowercase: true },
  password: { type: String, required: true },
  // store completed exercise ids with date
  completed: [
    {
      exercise: { type: mongoose.Schema.Types.ObjectId, ref: 'Exercise' },
      date: { type: Date, default: Date.now }
    }
  ]
}, { timestamps: true });

module.exports = mongoose.model('User', UserSchema);