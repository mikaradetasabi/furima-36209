class Residence < ApplicationRecord
  belongs_to :purchase
  belongs_to :user, optional: true
  validates :postal_code, :address ,presence: true
end