module Colors
  class RedWorker
    include Sidekiq::Job

    sidekiq_options queue: 'red'

    def perform
      puts "<<- RED ->>".red
    end
  end
end
