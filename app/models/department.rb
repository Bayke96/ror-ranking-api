class Department < ApplicationRecord

	# Class variables
	attribute :id, :integer
  attribute :name, :string
  attribute :employees, :integer, default: 0

  # Validations
  has_many :rank
  validates :name, presence: true, uniqueness: { message: "The department's name must be unique" }, length: { in: 3..128 }
  validates :employees, numericality: { only_integer: true }

end
