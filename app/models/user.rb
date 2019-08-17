class User < ApplicationRecord

  # Class variables
  attribute :id, :integer
  attribute :department_id, :integer
  attribute :rank_id, :integer
  attribute :name, :string
  attribute :password, :string

  # Validators
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :rank_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { message: "The user's name must be unique"}, length: { in: 3..128 }
  validates :password, presence: true, length: { in: 12..128 }

  def as_json(options={})
    options[:except] ||= [:password]
    super(options)
  end

end
