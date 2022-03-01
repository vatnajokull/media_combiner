module Seeds
  class CreateOrder
    class << self
      def call
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

      private

      def random_entities(klass, numbers = 1)
        klass.order('RANDOM()').limit(numbers)
      end
    end
  end
end
