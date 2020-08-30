class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|
      t.belongs_to :user
      t.belongs_to :one_hund_brand
      t.timestamps null: false
    end
  end
end
