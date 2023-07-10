class Scheduling < ApplicationRecord
  belongs_to :establishment
  belongs_to :user
  belongs_to :product
  belongs_to :professional, class_name: 'User'

end
