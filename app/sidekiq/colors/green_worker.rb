module Colors
  class GreenWorker
    include Sidekiq::Job

    sidekiq_options queue: 'green'

    def perform
      puts "<<- GREEN ->>".green
    end
  end
end
