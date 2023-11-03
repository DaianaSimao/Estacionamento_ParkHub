json.extract! entradas_financeira, :id, :tipo, :descricao, :total, :forma_pagamento, :responsavel, :obs, :created_at, :updated_at
json.url entradas_financeira_url(entradas_financeira, format: :json)
