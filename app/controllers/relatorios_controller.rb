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

    @media_tempo_dia = calcula_media_permanencia(@checkins_dia)
    @media_tempo_semana = calcula_media_permanencia(@checkins_semana)
    @media_tempo_mes = calcula_media_permanencia(@checkins_mes)
    @media_tempo_entre = calcula_media_permanencia(@checkins_entre)

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


    @periodo_de = @min
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

  def calcula_media_permanencia(checkins)
    if checkins.empty?
      return "0h 0m"
    else
      tempos_estadia = Caixa.where(checkin_id: checkins.map(&:id)).pluck(:tempo_estadia)
      minutos_estadia = tempos_estadia.map do |tempo_estadia|
        horas, minutos = tempo_estadia.split(':').map(&:to_i)
        horas * 60 + minutos
      end
      media_minutos = minutos_estadia.sum / minutos_estadia.size
      media_horas = media_minutos / 60
      minutos = media_minutos % 60
      
      return "#{media_horas}h #{minutos}m"
    end
  end
end
