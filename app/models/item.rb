class Item < ApplicationRecord
  
  has_one :purchase
  belongs_to :user
  has_many_attached :image
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :delivery
  belongs_to :days_delivery

  with_options presence: true do
    validates :product_name
    validates :description
    validates :image
    validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }
    validates :user_id
  end
  

  with_options presence: true, numericality: { other_than: 1, message: 'Select'} do
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :delivery_id
    validates :days_delivery_id
  end
end