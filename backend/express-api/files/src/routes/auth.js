const express = require('express');
const router = express.Router();

router.post('/login', (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }
  // TODO: validate against database and generate real JWT
  // Example: const token = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: '1h' });
  res.status(501).json({ error: 'Authentication not yet implemented — connect to your database' });
});

router.post('/register', (req, res) => {
  const { email, password, name } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }
  // TODO: create user in database, hash password with bcrypt
  // Example: const hash = await bcrypt.hash(password, 12);
  res.status(501).json({ error: 'Registration not yet implemented — connect to your database' });
});

module.exports = router;
