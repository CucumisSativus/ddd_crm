module Deals
  class Stage
    include ::Virtus.model
    include ActiveModel::Serialization

    attribute :name, String

    def initialize(name)
      @name = name
    end
  end
end