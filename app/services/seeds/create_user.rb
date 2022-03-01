module Seeds
  class CreateUser
    class << self
      def call
        user = FactoryBot.create(:user)
        user.create_location(location_attributes)
      end

      private

      def location_attributes
        FactoryBot.attributes_for(:location, city: Constants::Shared::CITIES.sample)
      end
    end
  end
end
