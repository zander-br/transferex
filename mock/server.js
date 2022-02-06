const express = require('express');
const { v4: uuidv4 } = require('uuid');

const app = express();
const port = process.env.PORT | 3333;

app.use(express.json());

app.post('/paymentOrders', (req, res) => {
  console.log(req.body);

  const internalId = uuidv4();
  const status = ['APPROVED', 'REJECTED'];
  const randomStatus = status[Math.random() * status.length | 0];

  res.status(201).json({
    internalId,
    status: randomStatus,
  });
});

app.listen(port, () => {
  console.log(`API de liquidação fake rodando na porta ${port}`)
});