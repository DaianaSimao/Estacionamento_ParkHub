class Vaga < ApplicationRecord
  has_many :checkins
  
  def status_display
    status ? 'Ocupada' : 'Disponível'
  end
end
