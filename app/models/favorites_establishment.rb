class FavoritesEstablishment < ApplicationRecord
	belongs_to :establishment
	belongs_to :user
end
