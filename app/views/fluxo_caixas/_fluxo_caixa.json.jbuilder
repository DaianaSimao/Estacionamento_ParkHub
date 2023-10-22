json.extract! fluxo_caixa, :id, :descricao, :categoria, :tipo, :valor, :forma_pagamento, :status, :data_vencimento, :created_at, :updated_at
json.url fluxo_caixa_url(fluxo_caixa, format: :json)
