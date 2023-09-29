class TicketService

  def self.calcular_valor_cobrado(checkin)
    hora_entrada = checkin.entrada
    hora_saida = checkin.saida
  
    diferenca_segundos = hora_saida - hora_entrada
  
    minutos_permanencia_total = (diferenca_segundos / 1.minute).ceil
    taxa_horaria = checkin.preco.preco_hora / 60
  
    valor_total = minutos_permanencia_total * taxa_horaria
    valor_total
  end
end
