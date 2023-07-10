class Establishment < ApplicationRecord
  has_one_attached :cover
  has_one_attached :avatar

  has_many :products
  has_one :address

  has_many :establishment_categories
  has_many :category_types, through: :establishment_categories

  has_many :schedulings
  has_many :users, through: :schedulings

  has_many :favorites_establishments
  has_many :users, through: :favorites_establishments


  has_and_belongs_to_many :users

end
