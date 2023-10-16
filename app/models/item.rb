class Item < ApplicationRecord
  has_one_attached :image
  has_one :order
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sales_status
  belongs_to :category
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_info
    validates :price, numericality:{only_integer:true,greater_than_or_equal_to:300,less_than_or_equal_to:9999999}
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :sales_status_id 
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
