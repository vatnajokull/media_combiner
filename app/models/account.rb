class Account < ApplicationRecord
  enum provider: { email: 0, facebook: 1, google: 2 }
  has_one :user, dependent: :destroy
end
