module V2
  class PostcardsController < ApplicationController
    def show
      Postcard::V2::CreateWorker.perform_async

      head :ok
    end
  end
end
