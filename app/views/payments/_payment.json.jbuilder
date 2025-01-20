json.extract! payment, :id, :payment_status, :due_date, :payment_method, :created_at, :updated_at
json.url payment_url(payment, format: :json)
