module RelatoriosHelper
  def em_permanencia(min,max)
    "Informaçôes sobre a média de permanência dos veículos no estacionamento do dia, semana, mês e também no período de #{l min, format: :default} até #{l max, format: :default}." 
  end

  def veiculos_estacionados
    "Informações sobre o numero de veículos no estacionamento de acordo com o dia, semana e mês"
  end

  def ranking_tipos
    "Informações sobre os tipos de veículos mais frequentes no estacionamento durante o mês."
  end

  def total_receitas(min,max)
    "Informações sobre o total de receitas do dia, semana, mês e também no período de #{l min, format: :default} até #{l max, format: :default}."
  end

  def total_despesas(min,max)
    "Informações sobre o total de despesas do dia, semana, mês e também no período de #{l min, format: :default} até #{l max, format: :default}."
  end

  def detalhes_despesas
    "Informações sobre as despesas operacionais (água, luz, internet, etc) do mês."
  end

  def grafico_despesas
    "Grafico para analise visual sobre as despesas operacionais (água, luz, internet, etc) do mês."
  end

  def lucro_liquido
    "Informações sobre o lucro liquido do dia, semana e mês."
  end
end
