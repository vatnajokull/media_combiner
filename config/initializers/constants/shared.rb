module Constants
  module Postcard
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
  end
end
