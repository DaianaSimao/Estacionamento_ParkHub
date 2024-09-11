module ApplicationHelper
  def formatar_valor(valor)
    number_to_currency(valor, unit: 'R$', separator: ',', delimiter: '.', precision: 2)
  end

  def formata_mudancas(mudanças)
    formatacao_mudanças = ""
    mudanças.each do |attribute, values|
      old_value, new_value = values
      formatacao_mudanças += "<strong>#{attribute}:</strong> De <em>#{old_value}</em> para <em>#{new_value}</em><br>"
    end
    formatacao_mudanças.html_safe
  end

  def formata_data(data)
    data.strftime("%d/%m/%Y")
  end

  def traduz_acao(acao)
    case acao
    when "create"
      "Criação"
    when "update"
      "Atualização"
    when "destroy"
      "Exclusão"
    end
  end
end
