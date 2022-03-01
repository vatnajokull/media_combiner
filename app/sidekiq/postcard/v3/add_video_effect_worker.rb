module Postcard
  module V3
    class AddVideoEffectWorker
      include Sidekiq::Job

      sidekiq_options queue: 'ffmpeg'

      def perform(filename, original_video_filename)
        Postcard::V3::AddVideoEffectService.call(filename, original_video_filename)
      end
    end
  end
end
