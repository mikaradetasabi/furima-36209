class PurchaseResidence
  include ActiveModel::Model
  attr_accessor :postal_code, :municipality, :delivery_id, :address, :phone_number, :building_name, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :municipality
    validates :delivery_id, numericality: { other_than: 1, message: 'Select' }
    validates :address 
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/, message: 'Input only number' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
  purchase = Purchase.create(user_id: user_id, item_id: item_id)
  Residence.create(postal_code: postal_code, municipality: municipality, delivery_id: delivery_id, address: address, phone_number: phone_number, building_name: building_name, purchase_id: purchase.id)
  end
end
