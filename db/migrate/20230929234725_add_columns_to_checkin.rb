class AddColumnsToCheckin < ActiveRecord::Migration[7.0]
  def change
    add_column :checkins, :entrada, :datetime
    add_column :checkins, :saida, :datetime
  end
end
