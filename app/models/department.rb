class Department < ApplicationRecord

	// Class variables
	attr_accessor :id, :name, :employees

  // Validations
  has_many :rank
  validates :name, presence: true, length: { in: 3..128 }
  validates :employees, numericality: { only_integer: true }

  // Constructors
  def initialize(name, employees)
    @name = name
    @employees = employees
	end

end
