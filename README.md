# 🛒 Shopping Cart API

API RESTful para gerenciamento de um carrinho de compras.

## Job de Limpeza Automática

O projeto inclui uma job (serviço em background) que executa periodicamente duas tarefas:

- **Limpeza de carrinhos não utilizados há mais de 3 horas**
- **Remoção de carrinhos não utilizados há mais de 7 dias**

## Endpoints

### 1. Registrar um produto no carrinho

**ROTA:** `/cart`  
**Método:** `POST`

**Payload:**
```json
{
  "product_id": 345,
  "quantity": 2
}
```

**Response:**
```json
{
  "id": 789,
  "products": [
    {
      "id": 645,
      "name": "Nome do produto",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98
    },
    {
      "id": 646,
      "name": "Nome do produto 2",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98
    }
  ],
  "total_price": 7.96
}
```

### 2. Listar itens do carrinho atual

**ROTA:** `/cart`  
**Método:** `GET`

**Response:**
```json
{
  "id": 789,
  "products": [
    {
      "id": 645,
      "name": "Nome do produto",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98
    },
    {
      "id": 646,
      "name": "Nome do produto 2",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98
    }
  ],
  "total_price": 7.96
}
```

### 3. Alterar a quantidade de produtos no carrinho

**ROTA:** `/cart/add_item`  
**Método:** `POST`

**Payload:**
```json
{
  "product_id": 1230,
  "quantity": 1
}
```

**Response:**
```json
{
  "id": 1,
  "products": [
    {
      "id": 1230,
      "name": "Nome do produto X",
      "quantity": 2,
      "unit_price": 7.00,
      "total_price": 14.00
    },
    {
      "id": 1020,
      "name": "Nome do produto Y",
      "quantity": 1,
      "unit_price": 9.90,
      "total_price": 9.90
    }
  ],
  "total_price": 23.9
}
```

### 4. Remover um produto do carrinho

**ROTA:** `/cart/:product_id`  
**Método:** `DELETE`

## ⚙️ Informações Técnicas

### Dependências
- Ruby 3.3.1
- Rails 7.1.3.2
- PostgreSQL 16
- Redis 7.0.15

### 🚀 Execução do Projeto

#### Sem Docker
1. Instale as dependências:
```bash
bundle install
```

2. Execute o Sidekiq:
```bash
bundle exec sidekiq
```

3. Inicie o servidor:
```bash
bundle exec rails server
```

4. Rode os testes:
```bash
bundle exec rspec
```

#### Com Docker
Caso opte por usar Docker, utilize o comando abaixo:
```bash
docker-compose -f docker-compose.yml up
```
