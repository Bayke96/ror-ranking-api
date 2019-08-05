class Rank < ApplicationRecord

  // Class variables
  attr_accessor :id, :departmentfk, :name

  // Validators
  belongs_to :department
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { in: 3..128 }

  // Constructors
  def initialize(departmentfk, name)
    @departmentfk = departmentfk
    @name = name
        
end
