module ApplicationHelper
  def formatar_valor(valor)
    number_to_currency(valor, unit: 'R$', separator: ',', delimiter: '.', precision: 2)
  end

  def format_changes(changes)
    formatted_changes = ""
    changes.each do |attribute, values|
      old_value, new_value = values
      formatted_changes += "<strong>#{attribute}:</strong> De <em>#{old_value}</em> para <em>#{new_value}</em><br>"
    end
    formatted_changes.html_safe
  end
end
