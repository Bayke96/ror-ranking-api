class RankPrivilege < ApplicationRecord
		
	# Class variables
	attr_accessor :id, :departmentfk, :rankfk, :create, :read, :update, :delete

  # Validations
  belongs_to :rank
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :rankfk, presence: true, numericality: { only_integer: true }
  validates :create, presence: true
  validates :read, presence: true
  validates :update, presence: true
  validates :delete, presence: true

  # Constructors
	def initialize(departmentfk, rankfk, create, read, update, delete)
		@departmentfk = departmentfk
		@rankfk = rankfk
		@create = create
		@read = read
		@update = update
    @delete = delete
  end
  
	
end
