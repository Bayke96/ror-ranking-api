class User < ApplicationRecord

  # Class variables
  attr_accessor :id, :name, :password

  # Validators
  belongs_to :department
  belongs_to :rank
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :rankfk, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { message: "The user's name must be unique"}, length: { in: 3..128 }
  validates :password, presence: true, length: { in: 12..128 }

  # Constructors
	def initialize(departmentfk, rankfk, name, password)
		@departmentfk = departmentfk
		@rankfk = rankfk
		@name = name
    @password = password
  end

end
