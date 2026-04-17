require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');

const app = express();
const PORT = process.env.PORT || 5000;


// connect DB
connectDB();

// middlewares
app.use(cors());
app.use(express.json());

// routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/exercises', require('./routes/exercises'));

app.get('/', (req, res) => res.send('StreakFit backend running'));

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));