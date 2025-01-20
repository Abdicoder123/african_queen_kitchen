class CreateDishes < ActiveRecord::Migration[7.2]
  def change
    create_table :dishes do |t|
      t.integer :menu_id
      t.string :title
      t.text :description
      t.string :image_url
      t.integer :price
      t.string :customizable

      t.timestamps
    end
  end
end
