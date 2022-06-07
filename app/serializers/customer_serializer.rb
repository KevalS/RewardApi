class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :dob
end
