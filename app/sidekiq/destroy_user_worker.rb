class DestroyUserWorker
  include Sidekiq::Job

  sidekiq_options queue: 'critical',
                  retry: 3

  def perform(user)
    puts user.first_name
  end
end
