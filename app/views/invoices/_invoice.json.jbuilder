json.extract! invoice, :id, :invoice_date, :due_date, :total_amount, :invoice_status, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
