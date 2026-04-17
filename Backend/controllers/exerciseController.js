const Exercise = require('../models/Exercise');
const User = require('../models/User');

exports.getAll = async (req, res) => {
  try {
    const exercises = await Exercise.find().sort({ day: 1, title: 1 });
    res.json(exercises);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.getByDay = async (req, res) => {
  try {
    const { day } = req.params; // expect Monday, Tuesday, ...
    const exercises = await Exercise.find({ day });
    res.json(exercises);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.create = async (req, res) => {
  try {
    const { title, description, duration, target, difficulty, day } = req.body;
    const ex = new Exercise({ title, description, duration, target, difficulty, day });
    await ex.save();
    res.status(201).json(ex);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.markComplete = async (req, res) => {
  try {
    const { exerciseId } = req.body;
    const user = await User.findById(req.user._id);
    if (!user) return res.status(404).json({ message: 'User not found' });

    user.completed.push({ exercise: exerciseId, date: new Date() });
    await user.save();
    res.json({ message: 'Marked complete', completed: user.completed });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};