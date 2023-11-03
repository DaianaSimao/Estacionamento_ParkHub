class RelatoriosController < ApplicationController

  def estacionamento  
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

  def caixa
    if params[:min].present?
      hoje = params[:min].to_date
    else
      hoje = Date.today
    end

    @receitas_dia = Caixa.where("created_at >= ? AND created_at <= ?", hoje.beginning_of_day, hoje.end_of_day) + EntradasFinanceira.where("created_at >= ? AND created_at <= ?", hoje.beginning_of_day, hoje.end_of_day)
    @receitas_semana = Caixa.where("created_at >= ? AND created_at <= ?", (hoje - 1.week).beginning_of_day , hoje.end_of_day) +  EntradasFinanceira.where("created_at >= ? AND created_at <= ?", (hoje - 1.week).beginning_of_day , hoje.end_of_day)
    @receitas_mes = Caixa.where("created_at >= ? AND created_at <= ?",(hoje - 1.months).beginning_of_day , hoje.end_of_day ) +  EntradasFinanceira.where("created_at >= ? AND created_at <= ?",(hoje - 1.months).beginning_of_day , hoje.end_of_day ) 

    @despesas_dia = Despesa.where("created_at >= ? AND created_at <= ?", hoje.beginning_of_day, hoje.end_of_day)
    @despesas_semana = Despesa.where("created_at >= ? AND created_at <= ?", (hoje - 1.week).beginning_of_day , hoje.end_of_day)
    @despesas_mes = Despesa.where("created_at >= ? AND created_at <= ?",(hoje - 1.months).beginning_of_day , hoje.end_of_day )

    @lucro_liquido_dia = @receitas_dia.sum(&:total).to_f - @despesas_dia.sum(:valor)
    @lucro_liquido_semana = @receitas_semana.sum(&:total).to_f - @despesas_semana.sum(:valor)
    @lucro_liquido_mes = @receitas_mes.sum(&:total).to_f - @despesas_mes.sum(:valor)


    @periodo_de = (hoje - 1.months).to_date
    @periodo_ate = hoje.to_date
    @soma_por_categoria = @despesas_mes.group_by { |despesa| despesa[:categoria] }.map do |categoria, despesas|
      {
        categoria: categoria,
        total: despesas.sum { |despesa| despesa[:valor] }
      }
    end

    @chart_data = {
      labels: @soma_por_categoria.map { |item| item[:categoria] },
      datasets: [{
        data: @soma_por_categoria.map { |item| item[:total] },
        backgroundColor: ['#1253b2', '#6998de', '#5191f0', '#066aff', '#96b3dc','#58cef8'] # Substitua pelas cores desejadas
      }]
    }
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
