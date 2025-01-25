class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    @order = @invoice.order
    # Finalize the invoice and send it

    # Create service to grab the total amount
    service = FetchInvoiceService.new(@invoice.stripe_invoice_id)
    result = service.fetch_invoice

    # Update invoice and order model
    @invoice.update(invoice_status: "Payment Pending", total_amount: result )
    @order.update(status: "Confirmed", total_cost: result )


  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:stripe_invoice_id, :currency, :description, :total_amount, :invoice_status, order_attributes: [:status, :total_cost])
    end
end
