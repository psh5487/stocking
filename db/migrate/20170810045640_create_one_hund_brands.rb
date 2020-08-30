class CreateOneHundBrands < ActiveRecord::Migration
  def change
    create_table :one_hund_brands do |t|
      t.string :brand_img_src
      t.string :brand_title
      t.string :brand_number
      
      t.integer :brand_price
      t.integer :brand_eps
      t.integer :brand_bps
      t.float :brand_per
      t.float :brand_bizper
      t.float :brand_pbr
      t.float :brand_cashprofitratio
      t.float :brand_beta
      t.float :brand_bizprofitratio
      t.float :brand_netincomeratio
      t.float :brand_roe
      t.float :brand_dpsr
      
      t.timestamps null: false
    end
  end
end
