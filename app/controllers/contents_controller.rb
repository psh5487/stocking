class ContentsController < ApplicationController
  def index
  end
  
  def show
    # OneHundBrand.stock
    # OneHundBrand.brand_image
    @kospis = OneHundBrand.all
    @ksearch = @kospis.search(params[:search]).order(brand_title: :asc)
    if user_signed_in?
      @user = User.find_by(id: current_user.id)
      @bags = @user.bags
    end
  end
  
  def my_portfolio
    if user_signed_in?
      @user = User.find_by(id: current_user.id)
      @bags = @user.bags
      @length = @bags.length
      @m = Array.new
      @n = Array.new
      @good_brand = Array.new
      @bad_brand = Array.new
      
      for i in 0..(@bags.length-1)
        @m << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_beta
        @n << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_dpsr
      end
      
      # if @bags.nil?  
      #   if @m || @n.nil?
      #     for i in 0..(@bags.length-1)
      #       @m << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_beta
      #       @n << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_dpsr
            
      #     end
      #   else
      #     for i in 0..(@bags.length-1)
      #       @m << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_beta
      #       @n << (1/@bags.length.to_f) * OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_dpsr
            
      #     end
      #   end
      
      @beta = @m.sum
      @dpsr = @n.sum
      
      for i in 0..(@bags.length-1) 
        if OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_roe > 10
          @good_brand << OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_title
        else OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_roe <= 10
          @bad_brand << OneHundBrand.all[(@bags[i].one_hund_brand_id)-1].brand_title
        end
      end 
      
    end
  end
  
  def news
    if user_signed_in?
      @user = User.find_by(id: current_user.id)
      @bags = @user.bags
    end
  end
  
end

