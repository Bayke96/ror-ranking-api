class UserProfile < ApplicationRecord

	# Class variables
	attribute :id, :integer
	attribute :user_id, :integer
	attribute :firstname, :string
	attribute :lastname, :string
	attribute :email, :string
	attribute :phone_number, :string
	attribute :address, :string

  # Validators
	validates :userfk, presence: true, numericality: { only_integer: true }
	validates :firstname, presence: true, length: { in: 3..128 }
	validates :lastname, presence: true, length: { in: 3..128 }
	validates :email, presence: true, length: { in: 3..50 }
	validates :phonenumber, presence: true, length: { in: 3..50 }
	validates :address, presence: true, length: { in: 2..128 }

end
