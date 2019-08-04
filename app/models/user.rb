class User < ApplicationRecord
    belongs_to :department
    belongs_to :rank
end
