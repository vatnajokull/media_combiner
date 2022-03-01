class CreateOrderJob
  include Sidekiq::Job

  def perform
    Seeds::CreateOrder.call
  end
end
