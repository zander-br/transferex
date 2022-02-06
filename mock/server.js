const express = require('express');
const { v4: uuidv4 } = require('uuid');

const app = express();
const port = process.env.PORT | 3333;

app.use(express.json());

app.post('/paymentOrders', (_req, res) => {
  const internalId = uuidv4();
  const status = ['APPROVED', 'REJECTED'];
  const randomStatus = status[Math.random() * status.length | 0];
  const statusCode = getRandomStatusCode()

  if (statusCode !== 201) {
    return res.status(statusCode).json({
      message: 'simulated error'
    });
  }

  return res.status(statusCode).json({
    internalId,
    status: randomStatus,
  });
});

function getRandomStatusCode() {
  const randomInteger = getRandomInteger(1, 100);
  const errorsStatusCode = [500, 405];
  const randomErrorStatusCode = errorsStatusCode[Math.random() * errorsStatusCode.length | 0];

  // Para simular um situação de erro de forma randomica
  const isError = randomInteger % 3 === 0 && randomInteger % 5 === 0;
  return isError ? randomErrorStatusCode : 201
}

function getRandomInteger(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

app.listen(port, () => {
  console.log(`API de liquidação fake rodando na porta ${port}`)
});