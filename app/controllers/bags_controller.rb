class BagsController < ApplicationController
    before_action :authenticate_user!

  def bag_toggle
    bag = Bag.find_by(user_id: current_user.id,
                      one_hund_brand_id: params[:one_hund_brand])
    if bag.nil?
      Bag.create(user_id: current_user.id,
                 one_hund_brand_id: params[:one_hund_brand])
    else
      bag.destroy
    end

    redirect_to :back
  end
end

