if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'Sample data for local development environment'
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      @cities = Array.new(rand(7..12)) { FFaker::AddressUA.city }.uniq

      def create_categories
        create_list(:category, rand(10..20))
      end

      def create_authors
        create_list(:author, rand(50..120))
      end

      def create_books
        rand(300..8000).times do
          authors = random_entities(Author, rand(1..3))
          category = random_entities(Category).first

          book = create(:book, category: category)

          authors.each { |author| book.authors_books.create!(author: author) }
        end
      end

      def create_users
        rand(150_000..400_000).times do
          user = create(:user)
          user.create_location(location_attributes)
        end
      end

      def create_orders
        rand(500_000..1_000_000).times do
          user = random_entities(User).first

          # 10% of orders are outdated
          outdated_date = Date.today.ago(rand(1..90).days)
          return_date = rand(0..9) > 8 ?  outdated_date : nil
          status = return_date.present? ? 'open' : 'closed'

          order = Order.new(user: user, return_date: return_date, status: status)

          # ordered books
          books = random_entities(Book, rand(1..6))
          books.each { |book| order.order_items.new(book: book) }

          order.save
        end
      end

      def random_entities(klass, numbers = 1)
        klass.order('RANDOM()').limit(numbers)
      end

      def location_attributes
        attributes_for(:location, city: @cities.sample)
      end

      create_categories
      create_authors
      create_books
      create_users
      create_orders
    end
  end
end
