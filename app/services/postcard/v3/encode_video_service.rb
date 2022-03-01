module Postcard
  module V3
    class EncodeVideoService
      def self.call(filename, noise_video_filename)
        # encode file to H265
        video_4k_filename = "#{filename}_#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('4k', 'suffix')}.#{Constants::Postcard::VIDEO_CONTAINER}"
        final_video_command = %W(
          ffmpeg
          -i #{noise_video_filename }
          -c:v libx265
          -x265-params
          crf=25
          #{video_4k_filename}
        ).join(' ')

        system(final_video_command)

        # remove redundant files
        File.delete(noise_video_filename)

        Postcard::V3::ResizeVideoWorker.perform_async(filename, video_4k_filename)
      end
    end
  end
end
