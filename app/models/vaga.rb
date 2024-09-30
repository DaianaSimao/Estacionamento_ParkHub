class Vaga < ApplicationRecord
  has_many :checkins
  has_paper_trail

  validates :status, inclusion: { in: [true, false] }

  def status_display
    status ? 'Ocupada' : 'Disponível'
  end
end
