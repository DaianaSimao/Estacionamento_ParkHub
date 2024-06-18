#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

bundle exec rails assets:precompile
bundle exec rails assets:clean

# Função para verificar se o banco de dados está pronto
check_db() {
  echo "Waiting for the database to be ready..."
  until pg_isready -h $DB_HOST -p 5432 -U $DB_USERNAME; do
    sleep 1
  done
}

# Verifique se o banco de dados está pronto antes de rodar a task
check_db

# Execute a task específica do Rails
echo "Running specific Rails task..."
bin/rails admin:criar_novo_admin
bin/rails admin:criar_novo_funcionario

# Inicie o servidor Rails
echo "Starting Rails server..."
bin/rails server -b 0.0.0.0