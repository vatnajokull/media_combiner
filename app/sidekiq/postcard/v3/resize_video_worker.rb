module Postcard
  module V3
    class ResizeVideoWorker
      include Sidekiq::Job

      sidekiq_options queue: 'ffmpeg'

      def perform(filename, video_4k_filename)
        Postcard::V3::ResizeVideoService.call(filename, video_4k_filename)
      end
    end
  end
end
