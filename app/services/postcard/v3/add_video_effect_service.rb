module Postcard
  module V3
    class AddVideoEffectService
      def self.call(filename, original_video_filename)
        # add noises to original video
        noise_video_filename = "#{filename}_#{Constants::Postcard::NOISE_SUFFIX}.#{Constants::Postcard::NOISE_VIDEO_CONTAINER}"
        noise_video_command = %W(
          ffmpeg
          -i #{original_video_filename }
          -codec:v huffyuv
          -c:a pcm_s16le
          -bsf
          noise=1000000
          #{noise_video_filename}
        ).join(' ')

        system(noise_video_command)

        # delete redundand file
        File.delete(original_video_filename)

        Postcard::V3::EncodeVideoWorker.perform_async(filename, noise_video_filename)
      end
    end
  end
end
