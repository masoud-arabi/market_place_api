class Order < ApplicationRecord
  belongs_to :user

  validates :total, presence: true, numericality:{ greater_than_or_equal_to: 0}
  
end
