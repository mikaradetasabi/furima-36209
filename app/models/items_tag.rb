class ItemsTag

  include ActiveModel::Model
  attr_accessor :product_name, :description, :category_id, :status_id, :burden_id, :delivery_id, :days_delivery_id, :price, :user, :name

  with_options presence: true do
    validates :product_name
    validates :description
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :delivery_id
    validates :days_delivery_id
    validates :price
    validates :user
    validates :name
  end

  def save
    item = Item.create(item: item)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end