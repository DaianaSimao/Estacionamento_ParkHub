class AddReferencesACheckin < ActiveRecord::Migration[7.0]
  def change
    add_reference :checkins, :caixas, foreign_key: true
  end
end
