class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :portal_code, :prefecture_id, :city, :address, :building, :phone, :order_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :portal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :city
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(portal_code:, prefecture_id:, city:, address:, phone:, building:, order_id: order.id)
  end
end