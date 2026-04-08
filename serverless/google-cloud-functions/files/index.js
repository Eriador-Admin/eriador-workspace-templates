const functions = require('@google-cloud/functions-framework');

functions.http('helloWorld', (req, res) => {
  const name = req.query.name || 'World';
  console.log(`Request received: ${req.method} ${req.url}`);

  res.json({
    message: `Hello from {{FUNCTION_NAME}}!`,
    name,
    timestamp: new Date().toISOString(),
  });
});
