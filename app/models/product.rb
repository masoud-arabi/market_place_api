class Product < ApplicationRecord
  belongs_to :user

  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :filter_by_title, lambda{ |keyword| where('lower(title) LIKE ?', "%#{keyword.downcase}%")}
  scope :above_or_equal_to_price, lambda{ |price| where('price >= ?', price)}
  scope :lower_or_equal_to_price, lambda{ |price| where('price <= ?', price)}

end
