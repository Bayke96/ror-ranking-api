class Rank < ApplicationRecord

  # Class variables
  attribute :id, :integer
  attribute :department_id, :integer
  attribute :name, :string

  # Validators
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { message: "The rank's name must be unique" }, length: { in: 3..128 }

end
