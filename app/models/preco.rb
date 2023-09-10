class Preco < ApplicationRecord
  validates :tipo, presence: true
  validates :preco_hora, presence: true

  before_save :capitalizar_nome

  def capitalizar_nome
    self.tipo = tipo.titleize if tipo.present?

  end
end
