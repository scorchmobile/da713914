# This Controller is used to faciliate the mobile app and the payment process

class Api::PaymentsController < ApplicationController

  layout false
  before_action :set_api_payment, only: [:show, :edit, :update, :destroy]

  # GET /api/payments
  # GET /api/payments.json
  def index
    @api_payments = Api::Payment.all
  end

  # GET /api/payments/1
  # GET /api/payments/1.json
  def show
  end

  # GET /api/payments/new
  def new
    @api_payment = Api::Payment.new
  end

  # GET /api/payments/1/edit
  def edit
  end

  # POST /api/payments
  # POST /api/payments.json
  def create
    @api_payment = Api::Payment.new(api_payment_params)

    respond_to do |format|
      if @api_payment.save
        format.html { redirect_to @api_payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @api_payment }
      else
        format.html { render :new }
        format.json { render json: @api_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/payments/1
  # PATCH/PUT /api/payments/1.json
  def update
    respond_to do |format|
      if @api_payment.update(api_payment_params)
        format.html { redirect_to @api_payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_payment }
      else
        format.html { render :edit }
        format.json { render json: @api_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/payments/1
  # DELETE /api/payments/1.json
  def destroy
    @api_payment.destroy
    respond_to do |format|
      format.html { redirect_to api_payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Mobile Payment Sign Up Form (needs param)
  def mobile_form
    @user_id = params[:user_id] || 1
    # FORM URL: create_from_mobile_form_api_payments_path
  end

  # Create the Payment Profile on the Merchant Account
  def create_from_mobile_form
    user = UserInterface.new user_id: api_payment_params[:user_id]
    AuthorizeNet.create_authortize_net_user user

    respond_to do |format|
      format.html { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_api_payment
      @api_payment = Api::Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_payment_params
      params.require(:payment).permit(:cc_number, :cc_year, :cc_month, :cc_cvv, :user_id, :user_type_id,
                                      :billing_street1, :billing_street2, :billing_city, :billing_state, :billing_zipcode,
                                      :shipping_street1, :shipping_street2, :shipping_city, :shipping_state, :shipping_zipcode)
    end
end
