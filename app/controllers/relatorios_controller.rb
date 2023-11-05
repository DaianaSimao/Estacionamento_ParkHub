class RelatoriosController < ApplicationController

  def estacionamento  
    if params[:min].present? && params[:max].present?
      @min = (params[:min] + " 00:00").to_datetime + 3.hours
      @max = (params[:max] + " 24:00").to_datetime + 3.hours
    else
      @min = Date.today
      @max = Date.today
    end

    @periodo_de = (@min - 1.months).to_date
    @periodo_ate = @max.to_date

    @checkins_dia = Checkin.where("entrada >= ? AND entrada <= ?", @min.beginning_of_day, @min.end_of_day)
    @checkins_semana = Checkin.where("entrada >= ? AND entrada <= ?", (@min - 1.week).beginning_of_day , @min.end_of_day)
    @checkins_mes = Checkin.where("entrada >= ? AND entrada <= ?",(@min - 1.months).beginning_of_day , @min.end_of_day )
    @checkins_entre = Checkin.where("entrada >= ? AND entrada <= ?",@min.beginning_of_day , @max.end_of_day )


    @media_tempo_permanencia_dia = inteirar_checkins(@checkins_dia)
    @media_tempo_permanencia_semana = inteirar_checkins(@checkins_semana)
    @media_tempo_permanencia_mes = inteirar_checkins(@checkins_mes)
    @media_tempo_permanencia_entre= inteirar_checkins(@checkins_entre)

    
    # Método de classe para encontrar os tipos de veículos mais frequentes
    @veiculos = @checkins_mes.map { |checkin| checkin.preco.tipo }
    # Contar a frequência de cada tipo de veículo
    @frequencia_veiculos = @veiculos.tally
    # Ordenar a frequência em ordem decrescente
    @frequencia_veiculos = @frequencia_veiculos.sort_by { |veiculo, frequencia| -frequencia }
  end

  def caixa
    if params[:min].present? && params[:max].present?
      @min = params[:min].to_date
      @max = params[:max].to_date
    else
      @min = Date.today
      @max = Date.today
    end

    @receitas_dia = Caixa.where("created_at >= ? AND created_at <= ?", @min.beginning_of_day, @min.end_of_day) + EntradasFinanceira.where("created_at >= ? AND created_at <= ?", @min.beginning_of_day, @min.end_of_day)
    @receitas_semana = Caixa.where("created_at >= ? AND created_at <= ?", (@min - 1.week).beginning_of_day , @min.end_of_day) +  EntradasFinanceira.where("created_at >= ? AND created_at <= ?", (@min - 1.week).beginning_of_day , @min.end_of_day)
    @receitas_mes = Caixa.where("created_at >= ? AND created_at <= ?",(@min - 1.months).beginning_of_day , @min.end_of_day ) +  EntradasFinanceira.where("created_at >= ? AND created_at <= ?",(@min - 1.months).beginning_of_day , @min.end_of_day ) 
    @receita_entre = Caixa.where("created_at >= ? AND created_at <= ?",@min.beginning_of_day , @max.end_of_day ) +  EntradasFinanceira.where("created_at >= ? AND created_at <= ?",@min.beginning_of_day , @max.end_of_day )

    @despesas_dia = Despesa.where("created_at >= ? AND created_at <= ?", @min.beginning_of_day, @min.end_of_day)
    @despesas_semana = Despesa.where("created_at >= ? AND created_at <= ?", (@min - 1.week).beginning_of_day , @min.end_of_day)
    @despesas_mes = Despesa.where("created_at >= ? AND created_at <= ?",(@min - 1.months).beginning_of_day , @min.end_of_day )
    @despesas_entre = Despesa.where("created_at >= ? AND created_at <= ?",@min.beginning_of_day , @max.end_of_day )

    @lucro_liquido_dia = @receitas_dia.sum(&:total).to_f - @despesas_dia.sum(:valor)
    @lucro_liquido_semana = @receitas_semana.sum(&:total).to_f - @despesas_semana.sum(:valor)
    @lucro_liquido_mes = @receitas_mes.sum(&:total).to_f - @despesas_mes.sum(:valor)
    @lucro_liquido_entre = @receita_entre.sum(&:total).to_f - @despesas_entre.sum(:valor)


    @periodo_de = (@min - 1.months).to_date
    @periodo_ate = @max.to_date
    @soma_por_categoria = @despesas_entre.group_by { |despesa| despesa[:categoria] }.map do |categoria, despesas|
      {
        categoria: categoria,
        total: despesas.sum { |despesa| despesa[:valor] }
      }
    end

    @chart_data = {
      labels: @soma_por_categoria.map { |item| item[:categoria] },
      datasets: [{
        data: @soma_por_categoria.map { |item| item[:total] },
        backgroundColor: ['#1253b2', '#6998de', '#5191f0', '#066aff', '#96b3dc','#58cef8']
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

  def inteirar_checkins(checkins)
    total_tempo = 0
    total_registros = 0
    checkins.each do |checkin|
      tempo_permanencia = tempo_permanencia_em_minutos(checkin.entrada, checkin.saida)
      total_tempo += tempo_permanencia
      total_registros += 1
      @media_tempo_permanencia = calcula_media_minuto(total_tempo, total_registros)
    end
    @media_tempo_permanencia
  end
end
