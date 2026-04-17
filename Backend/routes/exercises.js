const express = require('express');
const router = express.Router();
const auth = require('../middlewares/authMiddleware');
const {
  getAll,
  getByDay,
  create,
  markComplete
} = require('../controllers/exerciseController');

// Public: get all exercises
router.get('/', getAll);

// Public: get by day
router.get('/day/:day', getByDay);

// Protected: create exercise (admin/dev use)
router.post('/', auth, create);

// Protected: mark a user's completion
router.post('/complete', auth, markComplete);

module.exports = router;