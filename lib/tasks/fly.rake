namespace :fly do
  desc 'Run database migrations on Fly.io'
  task :migrate do
    sh 'bundle exec rake db:migrate'
  end
end