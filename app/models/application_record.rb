class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.not_found_error_class
    ActiveRecord::RecordNotFound
  end

  def self.record_invalid_error_class
    ActiveRecord::RecordInvalid
  end
end
