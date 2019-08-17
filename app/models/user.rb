class User < ApplicationRecord

  # Class variables
  attribute :id, :integer
  attribute :name, :string
  attribute :password, :string

  # Validators
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :rankfk, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { message: "The user's name must be unique"}, length: { in: 3..128 }
  validates :password, presence: true, length: { in: 12..128 }

end
