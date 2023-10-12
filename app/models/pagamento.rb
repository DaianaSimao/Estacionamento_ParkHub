class Pagamento < ApplicationRecord
  belongs_to :checkin
  self.table_name = "pagamentos"
end
