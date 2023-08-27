class AddEmPermanenciaToCheckins < ActiveRecord::Migration[7.0]
  def change
    add_column :checkins, :em_permanencia, :boolean
  end
end
