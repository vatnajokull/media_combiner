FactoryBot.define do
  factory :order do
    user
    return_date { FFaker::Time.date }
    status { 'open' }

    trait :with_order_items do
      transient do
        order_items_number { 1 }
      end

      after :create do |order, evaluator|
        create_list(:order_item, evaluator.order_items_number, order: order)
      end
    end
  end
end
