namespace :admin do
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Cria um novo funcionario"
  task criar_novo_funcionario: :environment do
    puts "Criação de um novo usuário"
    user = User.create(email: "func2.ph@ph.com",
      password: "123456",
      role: "Funcionario")
    puts "Novo usuário criado: #{user.email}"
  end

  desc "Cria um novo Administrador"
  task criar_novo_admin: :environment do
    puts "Criação de um novo usuário"
    user = User.create(email: "admin.ph@ph.com",
      password: "123456",
      role: "Admin")
    puts "Novo Administrador criado: #{user.email}"
  end

  desc "Seta numero do ticket para todos os checkins"
  task setar_ticket: :environment do
    puts "Setando tickets...."
    Checkin.all.each do |checkin|
      checkin.update(numero_ticket: SecureRandom.random_number(100000..999999))
    end
    puts "Finalizado..."
  end

  desc "Corrigir descrição de um fluxo de caixa"
  task corrigir_descricao: :environment do
    puts "Corrigindo descrição..."
    fluxo = FluxoCaixa.find(44)
    fluxo.update(descricao: "Caixa")
    puts "Finalizado..."
  end
end