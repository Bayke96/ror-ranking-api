class Rank < ApplicationRecord

  # Class variables
  attr_accessor :id, :departmentfk, :name

  # Validators
  belongs_to :department
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { message: "The rank's name must be unique" },length: { in: 3..128 }

  # Constructors
  def initialize(departmentfk, name)
    @departmentfk = departmentfk
    @name = name
  end
        
end
