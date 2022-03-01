module Postcard
  module V3
    class EncodeVideoWorker
      include Sidekiq::Job

      sidekiq_options queue: 'ffmpeg'

      def perform(filename, noise_video_filename)
        Postcard::V3::EncodeVideoService.call(filename, noise_video_filename)
      end
    end
  end
end
