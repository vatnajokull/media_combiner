module V3
  class PostcardsController < ApplicationController
    def show
      Postcard::V3::GenerateAudioWorker.perform_async

      head :ok
    end
  end
end
