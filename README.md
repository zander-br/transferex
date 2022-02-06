<h1 align="center">🤑 Transferex</h1>
<h3 align="center">Microserviço para transferência de dinheiro construído com Elixir 💚
</h3>

<p align="center">
  <img alt="Codecov" src="https://img.shields.io/codecov/c/github/zander-br/transferex?style=for-the-badge">
</p>

# Tabela de conteúdos

- [Sobre o projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Como executar o projeto](#-como-executar-o-projeto)
  - [Pré-requisitos](#pré-requisitos)
  - [Rodando o banco de dados](#user-content--rodando-o-banco-de-dados)
  - [Rodando o microserviço mock de liquidação](#user-content--rodando-o-microserviço-mock-de-liquidação)
  - [Rodando o microserviço de transferência](#user-content--rodando-o-microserviço-de-transferência)
- [Tecnologias](#-tecnologias)
- [Autor](#-autor)

## 💻 Sobre o projeto

🤑 Transferex - É um microserviço desenvolvido 100% em [Elixir](https://elixir-lang.org/) que tem como objetivo realizar operações de transferências ao qual integra-se com um serviço de Liquidação para a efetivação da transação. O protocolo de comunicação utilizado para as operações e comunicação é o HTTP, mais por sua vez internamente é utilizado sistema de filas, gerando com isso uma comunicação assíncrona.

## ⚙️ Funcionalidades

- [x] Cadastro de uma nova transferência
- [x] Consulta de uma transferência

## 🚀 Como executar o projeto

Este projeto, possui a dependência do microserviço de _Liquidação_ ao qual é necessário estar sendo executado no endereço `http://localhost:3333`

💡 Para auxiliar-lhe nesse processo também criamos um projeto mock para o microserviço de _Liquidação_.

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:

- [Git](https://git-scm.com)
- [Elixir](https://elixir-lang.org/install.html)
- [Node.js](https://nodejs.org/en/)
- [PostgreSQL](https://www.postgresql.org/), podendo ser usado um container docker.

#### 🎲 Rodando o banco de dados

Com o [Docker](https://www.docker.com/) instalado na máquina basta executar o comando abaixo para criar uma instância do [PostgreSQL](https://www.postgresql.org/) na sua máquina via container

```bash
docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```

#### 🧭 Rodando o microserviço mock de liquidação

```bash

# Acesse página do projeto
$ cd mock

# Instale as dependências
$ npm install

# Execute a aplicação em modo de desenvolvimento
$ npm run start

# A aplicação será aberta na porta:3333 - acesse http://localhost:3333

```

#### 🤑 Rodando o microserviço de transferência

```bash

# Instale as dependências e cria o banco de dados
$ mix setup

# Execute as Migrations
$ mix ecto.setup

# Execute os testes
$ mix test

# Execute o projeto
$ mix phx.server

# A aplicação será aberta na porta:4000 - acesse http://localhost:4000

```

<p align="center">
  <a href="https://github.com/zander-br/transferex/blob/main/insomnia.json" target="_blank"><img src="https://insomnia.rest/images/run.svg" alt="Run in Insomnia"></a>
</p>

## 🛠 Tecnologias

As seguintes ferramentas foram usadas na construção do projeto:

## 🦸 Autor

<a href="https://github.com/zander-br">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/51419725" width="100px;" alt=""/>
 <br />
 <sub><b>Anderson Santos</b></sub></a> <a href="https://github.com/zander-br" title="Rocketseat">🚀</a>
 <br />

[![Linkedin Badge](https://img.shields.io/badge/-Anderson-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/zander-br/)](https://www.linkedin.com/in/zander-br/)

Feito com ❤️ por Anderson Santos
