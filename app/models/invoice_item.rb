class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
end
