class Franchise < ApplicationRecord
	validates :name, :description, :address, :location, presence: true
end
