class Franchise < ApplicationRecord
	validates :name, :description, :address, :location, presence: true
  belongs_to :user
end
