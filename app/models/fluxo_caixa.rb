class FluxoCaixa < ApplicationRecord

  scope :criado_entre, -> min,max { where("fluxo_caixas.data_criacao BETWEEN ? AND ?",min,max) }

end
