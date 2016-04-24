module Deals
  class Stage
    LOST = 1
    QUALIFIED = 2
    IN_PROGRESS = 3
    WON = 4

    STAGES = {
        LOST => 'Lost',
        QUALIFIED => 'Qualified',
        IN_PROGRESS => 'In progress',
        WON => 'Won'
    }
    include ::Virtus.model
    include ActiveModel::Serialization

    attribute :name, String
    attribute :code, Integer
    def initialize(code)
      @code = code
      @name = STAGES[code]
    end
  end
end