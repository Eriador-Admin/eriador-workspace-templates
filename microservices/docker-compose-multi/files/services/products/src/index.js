const express = require('express');
const app = express();
const PORT = process.env.PORT || 3002;

app.use(express.json());

const products = [
  { id: 1, name: 'Widget', price: 9.99 },
  { id: 2, name: 'Gadget', price: 19.99 },
];

app.get('/api/products', (req, res) => {
  res.json(products);
});

app.get('/api/products/:id', (req, res) => {
  const product = products.find((p) => p.id === parseInt(req.params.id));
  if (!product) return res.status(404).json({ error: 'Product not found' });
  res.json(product);
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'products' });
});

app.listen(PORT, () => {
  console.log(`Products service running on port ${PORT}`);
});
