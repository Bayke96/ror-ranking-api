class RankPrivilege < ApplicationRecord
		
	# Class variables
  attribute :id, :integer
  attribute :department_id, :integer
  attribute :rank_id, :integer
  attribute :create, :boolean
  attribute :read, :boolean
  attribute :update, :boolean
  attribute :delete, :boolean

  # Validations
  validates :departmentfk, presence: true, numericality: { only_integer: true }
  validates :rankfk, presence: true, numericality: { only_integer: true }
  validates :create, presence: true
  validates :read, presence: true
  validates :update, presence: true
  validates :delete, presence: true

end
