module Postcard
  module V3
    class FinalizePostcardCreationService
      def self.call(video_4k_filename, video_full_hd_filename, video_720p_filename)
        urls = {
          '4k' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_4k_filename}",
          'full_hd' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_full_hd_filename}",
          '720p' => "https://some-bucket-name.s3.us-west-2.amazonaws.com/#{video_720p_filename}"
        }

        # notify user about created postcard
        TerminalNotifier.notify('Finished', subtitle: urls, sound: 'default')
      end
    end
  end
end
