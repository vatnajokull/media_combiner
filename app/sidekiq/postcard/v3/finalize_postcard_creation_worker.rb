module Postcard
  module V3
    class FinalizePostcardCreationWorker
      include Sidekiq::Job

      sidekiq_options queue: 'postcard'

      def perform(video_4k_filename, video_full_hd_filename, video_720p_filename)
        Postcard::V3::FinalizePostcardCreationService.call(video_4k_filename, video_full_hd_filename, video_720p_filename)
      end
    end
  end
end
