module Postcard
  module V2
    class CreateWorker
      include Sidekiq::Job

      sidekiq_options queue: 'postcard_creator'

      def perform
        Postcard::V2::CreatorService.call
      end
    end
  end
end
