json.extract! despesa, :id, :descricao, :valor, :categoria, :forma_pagamento, :status, :created_at, :updated_at
json.url despesa_url(despesa, format: :json)
