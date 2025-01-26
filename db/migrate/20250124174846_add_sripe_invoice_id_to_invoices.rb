class AddSripeInvoiceIdToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :stripe_invoice_id, :string
    add_column :invoices, :currency, :string
    add_column :invoices, :description, :text
    add_reference :invoices, :user
    remove_column :invoices, :due_date, :date
    remove_column :invoices, :invoice_date, :date
  end
end
