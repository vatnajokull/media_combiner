module Colors
  class YellowWorker
    include Sidekiq::Job

    sidekiq_options queue: 'yellow'

    def perform
      puts "<<- YELLOW ->>".yellow
    end
  end
end
