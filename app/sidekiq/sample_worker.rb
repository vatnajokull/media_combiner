class SampleWorker
  include Sidekiq::Job

  def perform
    puts "Hi, I'm a SampleWorker"
  end
end
