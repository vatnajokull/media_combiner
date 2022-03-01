module Postcard
  module V3
    class ResizeVideoService
      def self.call(filename, video_4k_filename)
        # resize video to 1080p
        video_full_hd_filename = "#{filename}_#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('full_hd', 'suffix')}.#{Constants::Postcard::VIDEO_CONTAINER}"
        system("ffmpeg -i #{video_4k_filename} -vf scale=#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('full_hd', 'resolution')} #{video_full_hd_filename}")

        # resize video to 720p'
        video_720p_filename = "#{filename}_#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('720p', 'suffix')}.#{Constants::Postcard::VIDEO_CONTAINER}"
        system("ffmpeg -i #{video_4k_filename} -vf scale=#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('720p', 'resolution')} #{video_720p_filename}")

        Postcard::V3::FinalizePostcardCreationWorker.perform_async(video_4k_filename, video_full_hd_filename, video_720p_filename)
      end
    end
  end
end
