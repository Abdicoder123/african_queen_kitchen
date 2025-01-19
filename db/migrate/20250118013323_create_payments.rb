class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :order
      t.string :payment_status
      t.date :due_date
      t.string :payment_method

      t.timestamps
    end
  end
end
