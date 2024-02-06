# Estacionamento ParkHub
![Logo do Estacionamento ParkHub](/app/assets/images/ParkHub.png)

Bem-vindo ao Estacionamento ParkHub! Este é um sistema completo para gerenciamento de estacionamento, projetado para atender às necessidades de empresas que buscam eficiência na administração de vagas de estacionamento. Com uma variedade de recursos, o ParkHub oferece uma solução abrangente para controle de entrada, saída, cobrança, relatórios e muito mais.

## Site: [Park Hub ](https://parkhub.fly.dev/)

## Funcionalidades Principais

### Cadastro de Vagas
- Possibilidade de cadastrar novas vagas para aumentar a capacidade do estacionamento.

### Check-in/Check-out
- Registra a entrada e saída de veículos.
- Calcula a cobrança com base no tempo de permanência.
- Permite a individualização da cobrança por tamanho do veículo.

### Tabela de Preços Dinâmica
- Configuração flexível da tabela de preços.
- Adaptação para diferentes tipos de veículos, como carros, motos e carretas.

### Impressão de Ticket Dinâmico
- Geração automática de tickets com informações relevantes.
- Personalização do layout do ticket conforme necessário.

### Upload de Comprovantes de Despesas
- Capacidade de fazer upload de comprovantes de despesas, como contas de água, que são armazenados no AWS S3 Bucket.

### Aporte de Capital
- Funcionalidade para registrar aportes de capital no sistema.

### Relatórios e Gráficos Dinâmicos
- Relatórios detalhados de entrada e saída.
- Gráficos dinâmicos para acompanhar gastos e lucros.
- Personalização de relatórios por período (diário, semanal, mensal).

### Fluxo de Caixa
- Relatórios de fluxo de caixa, incluindo receitas, despesas e o fluxo específico do estacionamento.

## Tecnologias Utilizadas

- Ruby 3
- Ruby on Rails 7
- PostgreSQL (Produção)
- SQLite (Desenvolvimento)
- Bootstrap (Frontend)
- AWS S3 Bucket (Armazenamento de Comprovantes)

## Configuração do Ambiente de Desenvolvimento

1. Instale as dependências usando `bundle install`.
2. Configure o banco de dados com `rails db:setup`.
3. Execute a aplicação com `rails server`.

Certifique-se de ajustar as configurações do AWS S3 Bucket e outras variáveis de ambiente conforme necessário.

## Contribuindo

Fique à vontade para contribuir, reportar problemas ou sugerir melhorias. Sua colaboração é fundamental para tornar o Estacionamento ParkHub ainda melhor!

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).
