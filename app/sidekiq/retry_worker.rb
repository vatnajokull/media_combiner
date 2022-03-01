class RetryWorker
  include Sidekiq::Job

  sidekiq_options queue: 'critical',
                  retry: 3

  def perform
    time = Time.now.to_i

    return time if (time % 2).positive?

    raise StandardError
  end
end
