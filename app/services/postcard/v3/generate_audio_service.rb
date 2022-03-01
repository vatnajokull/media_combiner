module Postcard
  module V3
    class GenerateAudioService
      def self.call
        locale = Constants::Postcard::LOCALES.sample
        dictionary = locale[:dictionary]
        ffaker_class = dictionary == 'en' ? FFaker::Lorem : "FFaker::Lorem#{dictionary.upcase}".constantize

        # generate audio
        phrase = ffaker_class.phrase
        filename = SecureRandom.hex
        audio_file = "#{filename}.#{Constants::Postcard::AUDIO_CONTAINER}"

        ESpeak::Speech.new(phrase, voice: locale[:voices].sample).save(audio_file)

        Postcard::V3::GenerateVideoWorker.perform_async(filename, phrase, audio_file)
      end
    end
  end
end
