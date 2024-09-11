class Vaga < ApplicationRecord
  has_many :checkins
  
  has_paper_trail

  def status_display
    status ? 'Ocupada' : 'Disponível'
  end
end
