class CreateUserJob
  include Sidekiq::Job

  def perform
    Seeds::CreateUser.call
  end
end
