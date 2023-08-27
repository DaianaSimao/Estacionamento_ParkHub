class AddNumeroTicketToCheckins < ActiveRecord::Migration[7.0]
  def change
    add_column :checkins, :numero_ticket, :string
  end
end
