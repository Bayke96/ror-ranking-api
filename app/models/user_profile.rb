class UserProfile < ApplicationRecord

	# Class variables
	attribute :id, :integer
	attribute :user_id, :integer
	attribute :firstname, :string
	attribute :lastname, :string
	attribute :email, :string
	attribute :phonenumber, :string
	attribute :address, :string

  # Validators
	validates :user_id, presence: true, numericality: { only_integer: true }, uniqueness: { message: "An user can only have a single profile" }
	validates :firstname, presence: true, length: { in: 3..128 }
	validates :lastname, presence: true, length: { in: 3..128 }
	validates :email, presence: true, length: { in: 3..50 }
	validates :phonenumber, presence: true, length: { in: 3..50 }
	validates :address, presence: true, length: { in: 2..128 }

end
