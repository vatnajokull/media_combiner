module Postcard
  module V3
    class GenerateVideoWorker
      include Sidekiq::Job

      sidekiq_options queue: 'ffmpeg'

      def perform(filename, phrase, audio_file)
        Postcard::V3::GenerateVideoService.call(filename, phrase, audio_file)
      end
    end
  end
end
