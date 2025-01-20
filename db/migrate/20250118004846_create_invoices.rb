class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :order
      t.date :invoice_date
      t.date :due_date
      t.decimal :total_amount
      t.string :invoice_status

      t.timestamps
    end
  end
end
