class EstablishmentCategory < ApplicationRecord
  belongs_to :establishment
  belongs_to :category_type
end
