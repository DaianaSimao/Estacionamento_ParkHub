class RelatoriosController < ApplicationController
  def index  
    if params[:min].present?
      hoje = params[:min].to_date
    else
      hoje = Date.today
    end

    @checkins_dia = Checkin.where("entrada >= ? AND entrada <= ?", hoje.beginning_of_day, hoje.end_of_day)
    @checkins_semana = Checkin.where("entrada >= ? AND entrada <= ?", (hoje - 1.week).beginning_of_day , hoje.end_of_day)
    @checkins_mes = Checkin.where("entrada >= ? AND entrada <= ?",(hoje - 1.months).beginning_of_day , hoje.end_of_day )

    total_tempo = 0
    total_registros = 0

    @checkins_dia.each do |checkin|
      tempo_permanencia = tempo_permanencia_em_minutos(checkin.entrada, checkin.saida)
      total_tempo += tempo_permanencia
      total_registros += 1
    end
    @media_tempo_permanencia_dia = calcula_media_minuto(total_tempo, total_registros)

    
    @checkins_semana.each do |checkin|
      tempo_permanencia = tempo_permanencia_em_minutos(checkin.entrada, checkin.saida)
      total_tempo += tempo_permanencia
      total_registros += 1
    end
    @media_tempo_permanencia_semana = calcula_media_minuto(total_tempo, total_registros)
    
    @checkins_mes.each do |checkin|
      tempo_permanencia = tempo_permanencia_em_minutos(checkin.entrada, checkin.saida)
      total_tempo += tempo_permanencia
      total_registros += 1
    end
    @media_tempo_permanencia_mes = calcula_media_minuto(total_tempo, total_registros)

    # Método de classe para encontrar os tipos de veículos mais frequentes
    veiculos = @checkins_mes.map { |checkin| checkin.preco.tipo }
    # Contar a frequência de cada tipo de veículo
    @frequencia_veiculos = veiculos.tally
    # Ordenar a frequência em ordem decrescente
    @frequencia_veiculos = @frequencia_veiculos.sort_by { |veiculo, frequencia| -frequencia }
  end
  def tempo_permanencia_em_minutos(entrada, saida)
    entrada = entrada
    saida = saida

    if entrada.present? && saida.present?
      diff = saida - entrada
      (diff / 60).to_i # Converter para minutos
    else
      0
    end
  end

  def calcula_media_minuto(total_tempo, total_registros)
    if total_registros > 0
      media_minutos = total_tempo / total_registros
      # Converte a média de volta para o formato "HH:MM"
      media_horas = media_minutos / 60
      media_minutos = media_minutos % 60
      @media_tempo_permanencia = format('%02dh %02dm', media_horas, media_minutos)
    else
      @media_tempo_permanencia = "00:00"
    end
  end
end
