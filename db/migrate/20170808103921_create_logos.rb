class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :firm_title
      t.string :logo_src

      t.timestamps null: false
    end
  end
end
