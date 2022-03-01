class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :provider,
             :email
end
