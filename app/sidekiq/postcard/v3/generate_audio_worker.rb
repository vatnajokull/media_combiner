module Postcard
  module V3
    class GenerateAudioWorker
      include Sidekiq::Job

      sidekiq_options queue: 'postcard'

      def perform
        Postcard::V3::GenerateAudioService.call
      end
    end
  end
end
