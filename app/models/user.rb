class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatables
  has_many :bags
  has_many :baged_one_hund_brands, through: :bags, source: :one_hund_brand
  
  def is_bag?(one_hund_brand)
    Bag.find_by(user_id: self.id, one_hund_brand_id: one_hund_brand.id).present?
  end
  
end
