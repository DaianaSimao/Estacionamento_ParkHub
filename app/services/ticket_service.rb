class TicketService

  def self.calcular_valor_cobrado(checkin)
    hora_entrada = checkin.entrada
    hora_saida = checkin.saida
  
    diferenca_segundos = hora_saida - hora_entrada
  
    minutos_permanencia_total = (diferenca_segundos / 1.minute).ceil
    taxa_horaria = checkin.preco.preco_hora / 60
    if minutos_permanencia_total > 60
      valor_total = minutos_permanencia_total * taxa_horaria
    else 
      valor_total = checkin.preco.preco_hora
    end
    valor_total.round(2)
  end
end
