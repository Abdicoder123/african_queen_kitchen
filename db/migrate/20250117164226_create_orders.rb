class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :delivery_date
      t.string :status
      t.text :event_details
      t.integer :group_size
      t.decimal :total_cost

      t.timestamps
    end
  end
end
