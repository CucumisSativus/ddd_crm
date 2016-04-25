class DealSerializer < ActiveModel::Serializer
  attributes :id, :name, :summary, :amount, :stage

  # def amount
  #   object.amount.to_s
  # end
end