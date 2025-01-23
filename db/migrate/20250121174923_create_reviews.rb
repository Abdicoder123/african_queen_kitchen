class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.integer :dish_id
      t.integer :user_id
      t.string :rating
      t.text :comment

      t.timestamps
    end
  end
end
