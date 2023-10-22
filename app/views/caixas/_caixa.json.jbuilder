json.extract! caixa, :id, :checkin_id, :forma_pagamento, :valor, :troco, :data_pagamento, :tempo_estadia, :status, :created_at, :updated_at
json.url caixa_url(caixa, format: :json)
