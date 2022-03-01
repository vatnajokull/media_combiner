module V1
  class PostcardsController < ApplicationController
    def show
      VIDEO_RESOLUTIONS = {
        '4k' => {
          'resolution' => '3840x2160',
          'suffix' => '4k',
        },
        'full_hd' => {
          'resolution' => '1920x1080',
          'suffix' => 'full_hd',
        },
        '720p' => {
          'resolution' => '1240x720',
          'suffix' => '720p',
        }
      }
      AUDIO_CONTAINER = 'mp3'
      VIDEO_CONTAINER = 'mp4'
      NOISE_VIDEO_CONTAINER = 'mkv'
      NOISE_SUFFIX = 'noise'
      LOCALES = [
        {
          dictionary: 'en',
          voices: %w(en en-sc en-uk en-uk-north en-uk-rp en-uk-wmids en-us en-wi)
        },
        {
          dictionary: 'br',
          voices: %w(pt pt-pt)
        },
        {
          dictionary: 'it',
          voices: %w(it)
        },
        {
          dictionary: 'fr',
          voices: %w(fr)
        },
        {
          dictionary: 'pl',
          voices: %w(pl)
        },
        {
          dictionary: 'ru',
          voices: %w(ru)
        },
        {
          dictionary: 'ua',
          voices: %w(ru)
        }
      ]

      def self.call
        locale = LOCALES.sample
        dictionary = locale[:dictionary]
        ffaker_class = dictionary == 'en' ? FFaker::Lorem : "FFaker::Lorem#{dictionary.upcase}".constantize

        # generate audio
        phrase = ffaker_class.phrase
        filename = SecureRandom.hex
        audio_file = "#{filename}.#{AUDIO_CONTAINER}"

        ESpeak::Speech.new(phrase, voice: locale[:voices].sample).save(audio_file)

        # generate video with audio
        background_color = FFaker::Color.hex_code
        text_color = FFaker::Color.hex_code
        original_video_filename = "#{filename}.#{VIDEO_CONTAINER}"

        original_video_command = %W(
          ffmpeg -f
          lavfi -i
          color=size=#{VIDEO_RESOLUTIONS.dig('4k', 'resolution')}:rate=25:color=#{background_color}
          -i #{audio_file}
          -vf "drawtext=fontsize=30:fontcolor=#{text_color}:x=(w-text_w)/2:y=(h-text_h)/2:text='#{phrase}'"
          -c:a copy
          -shortest
          #{original_video_filename}
        ).join(' ')

        system(original_video_command)

        # add noises to original video
        noise_video_filename = "#{filename}_#{NOISE_SUFFIX}.#{NOISE_VIDEO_CONTAINER}"
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

        # encode file to H265
        video_4k_filename = "#{filename}_#{VIDEO_RESOLUTIONS.dig('4k', 'suffix')}.#{VIDEO_CONTAINER}"
        final_video_command = %W(
          ffmpeg
          -i #{noise_video_filename }
          -c:v libx265
          -x265-params
          crf=25
          #{video_4k_filename}
        ).join(' ')

        system(final_video_command)

        # resize video to 1080p
        video_full_hd_filename = "#{filename}_#{VIDEO_RESOLUTIONS.dig('full_hd', 'suffix')}.#{VIDEO_CONTAINER}"
        system("ffmpeg -i #{video_4k_filename} -vf scale=#{VIDEO_RESOLUTIONS.dig('full_hd', 'resolution')} #{video_full_hd_filename}")

        # resize video to 720p'
        video_720p_filename = "#{filename}_#{VIDEO_RESOLUTIONS.dig('720p', 'suffix')}.#{VIDEO_CONTAINER}"
        system("ffmpeg -i #{video_4k_filename} -vf scale=#{VIDEO_RESOLUTIONS.dig('720p', 'resolution')} #{video_720p_filename}")

        # remove redundadnt files
        File.delete(audio_file)
        File.delete(original_video_filename)
        File.delete(noise_video_filename)

        urls = {
          '4k' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_4k_filename}",
          'full_hd' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_full_hd_filename}",
          '720p' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_720p_filename}",
        }
      end

      render json: { urls: urls }
    end
  end
end
