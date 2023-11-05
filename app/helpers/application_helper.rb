module ApplicationHelper
  def formatar_valor(valor)
    number_to_currency(valor, unit: 'R$', separator: ',', delimiter: '.', precision: 2)
  end
end
