module Postcard
  module V3
    class GenerateVideoService
      def self.call(filename, phrase, audio_file)
        background_color = FFaker::Color.hex_code
        text_color = FFaker::Color.hex_code
        original_video_filename = "#{filename}.#{Constants::Postcard::VIDEO_CONTAINER}"

        original_video_command = %W(
          ffmpeg -f
          lavfi -i
          color=size=#{Constants::Postcard::VIDEO_RESOLUTIONS.dig('4k', 'resolution')}:rate=25:color=#{background_color}
          -i #{audio_file}
          -vf "drawtext=fontsize=30:fontcolor=#{text_color}:x=(w-text_w)/2:y=(h-text_h)/2:text='#{phrase}'"
          -c:a copy
          -shortest
          #{original_video_filename}
        ).join(' ')

        system(original_video_command)

        # delete redundand file
        File.delete(audio_file)

        Postcard::V3::AddVideoEffectWorker.perform_async(filename, original_video_filename)
      end
    end
  end
end
