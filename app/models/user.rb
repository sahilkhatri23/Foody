class User < ApplicationRecord
  # attr_accessor :password, :password_confirmation
  has_secure_password
	# after_initialize :set_default_role, :if => :new_record?

  enum role: [:customer, :owner]
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # def set_default_role
  #   redirect_to admin_owners_path
  #   self.role ||= :customer
  # end
end
